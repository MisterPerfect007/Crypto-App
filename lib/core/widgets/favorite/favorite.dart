import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/coinInfo/presenter/widgets/coinNameImage/coin_name_image.dart';
import '../../../features/favorites/presenter/bloc/favorite_bloc.dart';
import '../../../features/favorites/utils/utils.dart';
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
  //
  @override
  void initState() {
    super.initState();
    //set a listener
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = false;
        print("$state !!!!!!!!!!!!!!!!!!!!!!!!!!");
        if (state is FavoriteLoaded) {
          isFavorite = state.ids.contains(widget.id);
        }
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              handleFavorite(context, widget.id);
              //
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: sidePadding, right: sidePadding, top: 10, bottom: 10),
              child: SvgIcon(
                icon:
                    isFavorite ? SvgIcons.favoriteSolid : SvgIcons.favoriteLine,
                color: isFavorite ? Colors.amber : AppColors.mainGrey,
              ),
            ),
          ),
        );
      },
    );
  }
}
