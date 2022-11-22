import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_trends/core/widgets/custom_network_image.dart';
import 'package:crypto_trends/core/widgets/favorite/favorite.dart';

import 'package:flutter/material.dart';

import '../../../../../services/firebase/auth/utils.dart';

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
                //TODOS : Check if user is Signed in
                if (isUserSignedIn()) {
                  // set data in firestore
                  CollectionReference favoriteCol = FirebaseFirestore.instance.collection('favorite');
                  favoriteCol.doc();
                  
                }

                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Favorite(isFavorite: isFavorite),
            ),
          )
        ],
      ),
    );
  }
}
