import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_trends/core/widgets/custom_network_image.dart';
import 'package:crypto_trends/core/widgets/favorite/favorite.dart';

import 'package:flutter/material.dart';

import '../../../../../core/utils/favorites_utils.dart';
import '../../../../coinList/domain/entities/coin.dart';

class CoinNameImage extends StatefulWidget {
  const CoinNameImage({
    Key? key,
    required this.coin,
  }) : super(key: key);
  final Coin coin;

  @override
  State<CoinNameImage> createState() => _CoinNameImageState();
}

class _CoinNameImageState extends State<CoinNameImage> {
  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: sidePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                CustomNetworkImage(
                  image: widget.coin.image,
                  name: widget.coin.name,
                  width: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                //Name
                Flexible(
                  child: Text(
                    widget.coin.name,
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

          Favorite(
            coin: widget.coin,
            onPressed: () => addOrRemoveFavorite(context, widget.coin.id),
          ),
        ],
      ),
    );
  }
}
