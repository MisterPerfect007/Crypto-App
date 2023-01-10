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
        ));
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

  late List<Coin> coinList = [];

  //
  bool isSomeFirestoreError = false;

  @override
  void initState() {
    super.initState();
    //
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //
      final favoritesOrError = await getFavoritesFromFirestore();
      //
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
      //
      if (!isSomeFirestoreError) {
        favoriteController.favorites.listen(handleFavoriteChanges);
      }
    });
  }

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
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }
              if (state is FavoriteListFailed) {}
              if (state is FavoriteListLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _removeAllItems();
                  state.coinList.forEach(_addSingleItems);
                });
                return Container();
              }
              return Container();
            },
          ),
          Expanded(
            child: AnimatedList(
              padding: const EdgeInsets.only(bottom: 70, top: 10),
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

  //
  Widget _buildListItem(Animation<double> animation, Coin coin, int index) {
    return ListItem(animation: animation, coin: coin);
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

  //
  ///Remove all items in the list
  void _removeAllItems() {
    final length = coinList.length;
    for (int i = length - 1; i >= 0; i--) {
      Coin removedItem = coinList.removeAt(i);
      builder(context, animation) {
        return _buildListItem(animation, removedItem, i);
      }

      _listKey.currentState?.removeItem(i, builder);
    }
  }
}

class ListItem extends StatefulWidget {
  const ListItem({
    Key? key,
    required this.animation,
    required this.coin,
  }) : super(key: key);

  final Animation<double> animation;
  final Coin coin;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isOnTapRunning = false;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: SingleCoin(
        coin: widget.coin,
        onFavoriteTap: !isOnTapRunning
            ? () async {
                setState(() {
                  isOnTapRunning = true;
                });
                final networkInfo = di.sl<NetworkInfo>();
                if (await networkInfo.isConnected) {
                  addOrRemoveFavorite(context, widget.coin.id);
                } else {
                  CustomToast.defaultToast(context, "No internet connection");
                }
                //if the widget still on tree => allow click
                if (mounted) {
                  setState(() {
                    isOnTapRunning = false;
                  });
                }
              }
            : () => null,
      ),
    );
  }
}
