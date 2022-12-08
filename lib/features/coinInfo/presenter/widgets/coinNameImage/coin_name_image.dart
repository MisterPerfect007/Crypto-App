import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_trends/core/widgets/custom_network_image.dart';
import 'package:crypto_trends/core/widgets/favorite/favorite.dart';

import 'package:flutter/material.dart';

import '../../../../../services/firebase/auth/utils.dart';
import '../../../../loginAndRegister/utils/utils.dart';

class CoinNameImage extends StatefulWidget {
  const CoinNameImage({
    Key? key,
    required this.name,
    required this.image,
    required this.id,
  }) : super(key: key);
  final String name;
  final String? image;
  final String id;

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
                handleFavorite(context, widget.id);
                //
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Favorite(id: widget.id),
            ),
          )
        ],
      ),
    );
  }
}

//1 => set a loader
//if sended ? show yellow star :otherwise show an error message
//
void handleFavorite(BuildContext context, String id) {
  //TODOS : Check if user is Signed in

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
    CollectionReference favoriteCol =
        FirebaseFirestore.instance.collection('favorite');
    //
    final doc = favoriteCol.doc(userUid);

    doc.get().then((doc) {
      //! doc.data() could be Null
      final mapData = doc.data();

      Map<String, dynamic> formatedMapData = {};

      if (mapData != null) {
        //TODOS: need to add or remove the given coin ID
        formatedMapData = mapData as Map<String, dynamic>;
        //
        List<String>? favoriteArray;
        //
        if (formatedMapData["favorites"] != null) {
          //todo: add or remove element
          favoriteArray = List<String>.from(formatedMapData["favorites"]);
          if (favoriteArray.contains(id)) {
            favoriteArray.remove(id);
          } else {
            favoriteArray.add(id);
          }
          favoriteCol.doc(userUid).update({'favorites': favoriteArray});
        } else {
          //array not found
          //todo: set a new array
          favoriteCol.doc(userUid).update({
            'favorites': [id]
          });
        }
        //
        if (favoriteArray == null) {
          favoriteCol.doc(userUid).set({
            'favorites': [id]
          });
        }
      } else {
        //doc no found
        // Todo: So add new id array with a single element
        favoriteCol.doc(userUid).set({
          'favorites': [id]
        });
      }
    }).onError((error, stackTrace) async {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$error");
    }).catchError(() => print(">>>>>>>>>>>>>>>><< Error catched"));
  }
}
