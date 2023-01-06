import 'package:crypto_trends/core/widgets/toast/toast.dart';
import 'package:crypto_trends/injection_container.dart' as di;
import 'package:crypto_trends/core/widgets/appBar/custom_app_bar.dart';
import 'package:crypto_trends/features/favorites/presenter/bloc/favorite_list_bloc.dart';
import 'package:crypto_trends/ui/icons/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/utils/favorites_utils.dart';
import '../../../../core/widgets/errors/error_message.dart';
import '../../../../services/firebase/auth/utils.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../../../coinList/presenter/widgets/single coin/single_coin.dart';
import '../../utils/utils.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) => di.sl<FavoriteListBloc>(),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(
              size.width,
              50,
            ),
            child: const CustomAppBar(
              title: "Favorite ⭐",
            ),
          ),
          body: const Body(),

          //! some favorite

          //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!new request!!!!!!!!!!!!!!!
          //make request with ids

          //&& when add new id make ==> request and add it

          //  SizedBox(
          //     height: size.height,
          //     child: AnimatedList(
          //       key: _listKey,
          //       initialItemCount: 5,
          //       itemBuilder: (context, index, animation) {
          //         return _buildListItem(animation, index);
          //       },
          //     )),
        ));
  }

  InkWell _buildListItem(Animation<double> animation, int index) {
    return InkWell(
      onTap: () {
        builder(context, animation) {
          return _buildListItem(animation, index);
        }

        _listKey.currentState?.removeItem(index, builder);
      },
      child: SizeTransition(
        sizeFactor: animation,
        child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 5),
            color: Colors.red,
            child: Text("data$index")),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  late List<String> favoritesIds = [];

  late List<Coin> coinList;

  bool isSomeFirestoreError = false;

  @override
  void initState() {
    super.initState();
    //
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await Future.delayed(Duration(seconds: 5));
      final favoritesOrError = await getFavoritesFromFirestore();
      favoritesOrError.fold((error) {
        isSomeFirestoreError = true;
      }, (favorites) {
        setState(() {
          favoritesIds = favorites;
        });
        //! load favorite ids
        if (favoritesIds.isNotEmpty && !isSomeFirestoreError) {
          context.read<FavoriteListBloc>().add(GetFavoriteList(favoritesIds));
        }
      });
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    final size = MediaQuery.of(context).size;
    //
    if (isSomeFirestoreError) {
      return const CustomErrorWidget(
        icon: SvgIcons.badO,
        msg: "Something went wrong when try to load",
      );
    } else if (favoritesIds.isEmpty) {
      return //! empty favorite list
          const Center(
        child: Text("No Favorite added yet."),
      );
    } else if (favoritesIds.isNotEmpty) {
      //! favorite ids are loaded
      return BlocBuilder<FavoriteListBloc, FavoriteListState>(
        builder: (context, state) {
          if (state is FavoriteListLoading) {
            return const Center(child: Text("Loading ............"));
          } else if (state is FavoriteListLoaded) {
            coinList = state.coinList;
            return SizedBox(
                height: size.height,
                child: AnimatedList(
                  key: _listKey,
                  initialItemCount: coinList.length,
                  itemBuilder: (context, index, animation) {
                    return _buildListItem(animation, coinList[index], index);
                  },
                ));
          } else if (state is FavoriteListFailed) {
            return const Center(child: Text("Failure ;"));
          }

          return const Center(child: Text("Unexpected error"));
        },
      );
      // return Container();
    } else {
      return const Center(child: Text("Unexpected last error"));
    }
  }

  Widget _buildListItem(Animation<double> animation, Coin coin, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: SingleCoin(
        coin: coin,
        onFavoriteTap: () async{

        final networkInfo = di.sl<NetworkInfo>();
          if (await networkInfo.isConnected) {
            print("Connected >>>>>>>>>>>>>>>>>>>>>");
            addOrRemoveFavorite(context, coin.id);
            _removeSingleItems(index);
          } else {
            CustomToast.defaultToast(context, "No internet connection");
          }
        }
        ,
      ),
    );
  }

  void _removeSingleItems(int removeIndex) {
    Coin removedItem = coinList.removeAt(removeIndex);
    builder(context, animation) {
      // A method to build the Card widget.
      return _buildListItem(animation, removedItem, removeIndex);
    }

    _listKey.currentState?.removeItem(removeIndex, builder);
  }
}
