import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../services/firebase/auth/utils.dart';

void handleFavorite(String userUid, String idCoin) {
  CollectionReference favoriteCol =
      FirebaseFirestore.instance.collection('favorite');
  //
  final doc = favoriteCol.doc(userUid);

  doc.get().then((doc) {
    //! doc.data() could be Null
    final mapData = doc.data();

    Map<String, dynamic> formatedMapData = {};

    if (mapData != null) {
      //= > need to add or remove the given coin ID
      formatedMapData = mapData as Map<String, dynamic>;
      //
      List<String>? favoriteArray;
      //
      if (formatedMapData["favorites"] != null) {
        // => add or remove element
        favoriteArray = List<String>.from(formatedMapData["favorites"]);
        if (favoriteArray.contains(idCoin)) {
          favoriteArray.remove(idCoin);
        } else {
          favoriteArray.add(idCoin);
        }
        favoriteCol.doc(userUid).update({'favorites': favoriteArray});
      } else {
        //array not found
        // => set a new array
        favoriteCol.doc(userUid).update({
          'favorites': [idCoin]
        });
      }
      //
      if (favoriteArray == null) {
        favoriteCol.doc(userUid).set({
          'favorites': [idCoin]
        });
      }
    } else {
      //doc no found
      // => So add new id array with a single element
      favoriteCol.doc(userUid).set({
        'favorites': [idCoin]
      });
    }
  }).onError((error, stackTrace) async {});
}

Future<Either<String, List<String>>> getFavoritesFromFirestore() async {
  String errorMsg = "defaultErrorMsg";
  bool someErrorOccurred = false;
  //
  List<String> ids;
  final docRef =
      FirebaseFirestore.instance.collection("favorite").doc(getUserUid());
  try {
    final doc = await docRef.get().catchError((object) {
      someErrorOccurred = true;
    });
    final data = doc.data() as Map<String, dynamic>;
    ids = List<String>.from(data["favorites"]);
    return Right(ids);
  } catch (e) {
    //
    if (someErrorOccurred) {
      return Left(errorMsg);
    }
    return const Right([]);
  }
  // return null;
}
