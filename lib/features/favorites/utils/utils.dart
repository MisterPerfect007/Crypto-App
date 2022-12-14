import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../controllers/get/favorite_controller.dart';

///set a listener to favorite document on FireStore

void listenToFavorite() {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  // final userUid = getUserUid();
  // if (userUid != null) {
  CollectionReference favoriteCol =
      FirebaseFirestore.instance.collection('favorite');
  favoriteCol
      .doc("doc1")
      .snapshots(includeMetadataChanges: true)
      .listen((event) {
    //!event.data() could be null
    try {
      final data = event.data() as Map<String, dynamic>;
      final ids = List<String>.from(data["favorites"]);

      favoriteController.favorites.value = ids;
      print(ids);
      print("---------------------");
    } catch (e) {
      //
    }
  });
  // }

}
