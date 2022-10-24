import 'package:crypto_trends/core/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/svg_icons.dart';

class CoinNameImage extends StatefulWidget {
  const CoinNameImage({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);
  final String name;
  final String? image;

  @override
  State<CoinNameImage> createState() => _CoinNameImageState();
}

class _CoinNameImageState extends State<CoinNameImage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(
        left: sidePadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                CustomNetworkImage(
                  image: widget.image,
                  name: widget.name,
                  width: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                //Name
                Flexible(
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: theme.primaryColor),
                  ),
                ),
              ],
            ),
          ),
          //Favorite
          //! to be extract
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: sidePadding, right: sidePadding, top: 10, bottom: 10),
                child: SvgIcon(
                  icon: isFavorite
                      ? SvgIcons.favoriteSolid
                      : SvgIcons.favoriteLine,
                  color: isFavorite ? Colors.amber : AppColors.mainGrey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
