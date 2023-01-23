import 'package:crypto_trends/core/widgets/animation/custom_opacity_animation.dart';
import 'package:crypto_trends/core/widgets/errors/error_message.dart';
import 'package:crypto_trends/core/widgets/toast/toast.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:crypto_trends/injection_container.dart' as di;
import 'package:crypto_trends/core/widgets/appBar/custom_app_bar.dart';
import 'package:crypto_trends/features/favorites/presenter/bloc/favorite_list_bloc.dart';
import 'package:crypto_trends/ui/icons/svg_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/utils/favorites_utils.dart';
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
              title: "Favorites list ⭐",
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
  List<String> favoritesIds = [];

  late List<Coin> coinList = [];

  //
  bool isSomeFirestoreError = false;
  //
  Future<bool> get isDeviceConnected => di.sl<NetworkInfo>().isConnected;

  @override
  void initState() {
    super.initState();
    //
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //

      await handleGetFavoritesFromFirestore();
      FirebaseAuth.instance.authStateChanges().listen((user) async {
        if (user != null) {
          await handleGetFavoritesFromFirestore();
        }
      });
    });
  }

  Future<void> handleGetFavoritesFromFirestore() async {
    //if first user is signed in
    if (isUserSignedIn()) {
      final favoritesOrError = await getFavoritesFromFirestore();
      //
      favoritesOrError.fold((error) {
        setState(() {
          isSomeFirestoreError = true;
        });
      }, (favorites) {
        setState(() {
          favoritesIds = favorites;
          isSomeFirestoreError = false;
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
    }
  }

  ///
  void handleFavoriteChanges(List<String> newList) {
    if (newList.length > favoritesIds.length) {
      //so new favorite added
      final List<String> idsToAdd =
          newList.where((element) => !favoritesIds.contains(element)).toList();
      //
      favoritesIds = favoritesIds + idsToAdd;

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
      print(idsToRemove);
      print("-----------------------------------------");
      //
      for (var id in idsToRemove) {
        //
        Coin coinToRemove = coinList.singleWhere((coin) => coin.id == id);
        int indexToRemove = coinList.indexOf(coinToRemove);
        _removeSingleItems(indexToRemove);
        //
        favoritesIds.remove(id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    if (isSomeFirestoreError) {
      return CustomErrorWidget(
        msg: "Something went wrong",
        icon: SvgIcons.badO,
        onPressed: () async {
          if (await isDeviceConnected) {
            await handleGetFavoritesFromFirestore();
          } else {
            CustomToast.defaultToast(context, "No internet connection");
          }
        },
      );
    } else {
      return Center(
        child: Column(
          children: [
            const IfFavoritesEmpty(),
            BlocBuilder<FavoriteListBloc, FavoriteListState>(
              builder: (context, state) {
                //!FavoriteListLoading
                if (state is FavoriteListLoading) {
                  return const Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  );
                }
                //! FavriteListFailed
                if (state is FavoriteListFailed) {
                  if (state.errorType == ErrorType.noInternetConnection) {
                    return CustomErrorWidget(
                      icon: SvgIcons.noWifiLine,
                      msg: "No internet",
                      onPressed: () async {
                        if (await isDeviceConnected) {
                          await handleGetFavoritesFromFirestore();
                        } else {
                          CustomToast.defaultToast(
                              context, "You still offline");
                        }
                      },
                    );
                  } else {
                    return CustomErrorWidget(
                      icon: SvgIcons.badO,
                      msg: "Something went wrong",
                      onPressed: () async {
                        if (await isDeviceConnected) {
                          await handleGetFavoritesFromFirestore();
                        } else {
                          CustomToast.defaultToast(
                              context, "You're still offline");
                        }
                      },
                    );
                  }
                }
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
                padding: const EdgeInsets.only(bottom: 70, top: 20),
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
  //
  bool isOnTapRunning = false;
  ////
  Future<bool> get isDeviceConnected => di.sl<NetworkInfo>().isConnected;

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
                if (await isDeviceConnected) {
                  await addOrRemoveFavorite(context, widget.coin.id);
                } else {
                  CustomToast.defaultToast(context, "No internet connection");
                }
                Future.delayed(const Duration(milliseconds: 500));
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

class IfFavoritesEmpty extends StatefulWidget {
  const IfFavoritesEmpty({Key? key}) : super(key: key);

  @override
  State<IfFavoritesEmpty> createState() => _IfFavoritesEmptyState();
}

class _IfFavoritesEmptyState extends State<IfFavoritesEmpty> {
  //
  final FavoriteController favoriteController = Get.put(FavoriteController());
  //
  bool isFavoriteEmpty = false;
  //
  @override
  void initState() {
    super.initState();
    favoriteController.favorites.listen((p0) {
      if (mounted) {
        setState(() {
          isFavoriteEmpty = p0.isEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    favoriteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    if (isFavoriteEmpty) {
      return CustomOpacityAnimation(
        child: Container(
            color: theme.primaryColor.withOpacity(0.3),
            width: Get.width,
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: const Center(
                child: Text(
              "Your favorites list is empty",
            ))),
      );
    }
    return Container();
  }
}
