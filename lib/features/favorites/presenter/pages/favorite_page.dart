import 'package:crypto_trends/core/widgets/toast/toast.dart';
import 'package:crypto_trends/injection_container.dart' as di;
import 'package:crypto_trends/core/widgets/appBar/custom_app_bar.dart';
import 'package:crypto_trends/features/favorites/presenter/bloc/favorite_list_bloc.dart';
import 'package:crypto_trends/ui/icons/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/utils/favorites_utils.dart';
import '../../../../core/widgets/errors/error_message.dart';
import '../../../../services/firebase/auth/utils.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../../../coinList/presenter/widgets/single coin/single_coin.dart';
import '../../controllers/get/favorite_controller.dart';
import '../../controllers/get/newly_added_controller.dart';
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
  //
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final FavoriteNewlyAddedController newlyAddedController =
      Get.put(FavoriteNewlyAddedController());
  //
  late List<String> favoritesIds = [];
  //
  late List<String> newlyAddedFavoritesIds = [];

  late List<Coin> coinList = [];

  //

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
        //! load favorite
        if (favoritesIds.isNotEmpty && !isSomeFirestoreError) {
          context.read<FavoriteListBloc>().add(GetFavoriteList(favoritesIds));
        }
      });
      if (!isSomeFirestoreError) {
        favoriteController.favorites.listen(handleFavoriteChanges);
      }
    });
    //
    //
  }

  //
  //
  ///
  void handleFavoriteChanges(newList) {
    if (newList.length > favoritesIds.length) {
      //so new favorite added
      final List<String> idsToAdd =
          newList.where((element) => !favoritesIds.contains(element)).toList();
      //
      favoritesIds.addAll(idsToAdd);

      final newlyAdded = List<Coin>.from(newlyAddedController.favorites);
      final toAddOnList =
          newlyAdded.where((element) => idsToAdd.contains(element.id));
      // print(toAddOnList.toList());
      toAddOnList.forEach(_addSingleItems);
    } else if (newList.length < favoritesIds.length) {
      //so favorite removed
      final List<String> idsToRemove =
          favoritesIds.where((element) => !newList.contains(element)).toList();
      //
      for (var id in idsToRemove) {
        Coin coinToRemove = coinList.singleWhere((coin) => coin.id == id);
        int indexToRemove = coinList.indexOf(coinToRemove);
        _removeSingleItems(indexToRemove);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: Column(
        children: [
          BlocBuilder<FavoriteListBloc, FavoriteListState>(
            builder: (context, state) {
              if (state is FavoriteListLoading) {
                return const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FavoriteListFailed) {}
              if (state is FavoriteListLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  state.coinList.forEach(_addSingleItems);
                });
                return Container();
              }
              return Container();
            },
          ),
          Expanded(
            child: AnimatedList(
              padding: const EdgeInsets.only(bottom: 70),
              key: _listKey,
              initialItemCount: coinList.length,
              itemBuilder: (context, index, animation) {
                return _buildListItem(animation, coinList[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(Animation<double> animation, Coin coin, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: SingleCoin(
        coin: coin,
        onFavoriteTap: () async {
          final networkInfo = di.sl<NetworkInfo>();
          if (await networkInfo.isConnected) {
            addOrRemoveFavorite(context, coin.id);
            // _removeSingleItems(index);
          } else {
            CustomToast.defaultToast(context, "No internet connection");
          }
        },
      ),
    );
  }

  void _removeSingleItems(int removeIndex) {
    Coin removedItem = coinList.removeAt(removeIndex);
    favoritesIds.remove(removedItem.id);
    builder(context, animation) {
      return _buildListItem(animation, removedItem, removeIndex);
    }

    _listKey.currentState?.removeItem(removeIndex, builder);
  }

  void _addSingleItems(Coin coin) {
    coinList.add(coin);
    _listKey.currentState?.insertItem(coinList.length - 1);
  }
}
