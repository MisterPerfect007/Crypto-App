import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_trends/features/favorites/presenter/bloc/favorite_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/firebase/auth/utils.dart';

///set a listener to favorite document on FireStore
void listenToFavorite(BuildContext context) {
  //
  final bloc = FavoriteBloc();

  CollectionReference favoriteCol =
      FirebaseFirestore.instance.collection('favorite');
  final userUid = getUserUid();
  if (userUid != null) {
    favoriteCol
        .doc(userUid)
        .snapshots(includeMetadataChanges: true)
        .listen((event) {
      //!event.data() could be null
      final data = event.data() as Map<String, dynamic>;
      final ids = List<String>.from(data["favorites"]);

      bloc.add(SetFavorite(ids));
      print(ids);
      print("---------------------");
      try {} catch (e) {
        //
      }
    });
  }
}
