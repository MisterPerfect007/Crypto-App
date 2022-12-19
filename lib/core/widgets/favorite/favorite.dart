import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../features/favorites/controllers/get/favorite_controller.dart';

import '../../../features/favorites/utils/utils.dart';
import '../../../features/loginAndRegister/utils/utils.dart';
import '../../../services/firebase/auth/utils.dart';
import '../../../ui/colors/colors.dart';
import '../../../ui/icons/svg_icons.dart';

class Favorite extends StatefulWidget {
  const Favorite({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final FavoriteController favoriteController = Get.put(FavoriteController());
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
      isFavorite = favorites.contains(widget.id);

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            //
            final String? userUid = getUserUid();
            //check if user is loged in
            if (userUid == null) {
              //User should logged in
              showCustomDialog(
                context,
                type: CustomDialog.warning,
                bodyText: 'Log in and enjoy',
                onSubmit: () {},
                submitText: 'Log in',
                title: 'You are not Logged in',
              );
            } else {
              handleFavorite(userUid, widget.id);
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
