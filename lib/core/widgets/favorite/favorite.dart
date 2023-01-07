import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../features/favorites/controllers/get/favorite_controller.dart';

import '../../../features/favorites/controllers/get/newly_added_controller.dart';
import '../../../ui/colors/colors.dart';
import '../../../ui/icons/svg_icons.dart';

class Favorite extends StatefulWidget {
  const Favorite({
    Key? key,
    required this.onPressed,
    required this.coin,
  }) : super(key: key);
  final Coin coin;
  final Future<void>? Function() onPressed;

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final FavoriteNewlyAddedController newlyAddedController =
      Get.put(FavoriteNewlyAddedController());
  //
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    //
    bool isFavorite = false;

    return Obx(() {
      final favorites = favoriteController.favorites;
      isFavorite = favorites.contains(widget.coin.id);

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            await widget.onPressed();
            if (!isFavorite) {
              newlyAddedController.add(widget.coin);
            }
          },
          child: Container(
              padding: EdgeInsets.only(
                  left: sidePadding, right: sidePadding, top: 10, bottom: 10),
              child: SvgIcon(
                icon:
                    isFavorite ? SvgIcons.favoriteSolid : SvgIcons.favoriteLine,
                color: isFavorite ? Colors.amber : AppColors.mainGrey,
              )),
        ),
      );
    });
  }
}
