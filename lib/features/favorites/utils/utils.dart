import 'package:cloud_firestore/cloud_firestore.dart';

void handleFavorite(String userUid, String idCoin) {
  //TODOS : Check if user is Signed in

  
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
          if (favoriteArray.contains(idCoin)) {
            favoriteArray.remove(idCoin);
          } else {
            favoriteArray.add(idCoin);
          }
          favoriteCol.doc(userUid).update({'favorites': favoriteArray});
        } else {
          //array not found
          //todo: set a new array
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
        // Todo: So add new id array with a single element
        favoriteCol.doc(userUid).set({
          'favorites': [idCoin]
        });
      }
    }).onError((error, stackTrace) async {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$error");
    }).catchError(() => print(">>>>>>>>>>>>>>>><< Error catched"));
  
}
