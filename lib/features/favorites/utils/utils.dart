import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_trends/features/favorites/presenter/bloc/favorite_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/firebase/auth/utils.dart';

///set a listener to favorite document on FireStore
StreamSubscription<DocumentSnapshot<Object?>>? listenToFavoriteFromFireStore(BuildContext context) {
  //
  //
  CollectionReference favoriteCol =
      FirebaseFirestore.instance.collection('favorite');
  final userUid = getUserUid();
  if (userUid != null) {
    return favoriteCol
        .doc(userUid)
        .snapshots(includeMetadataChanges: true)
        .listen((event) {
      //!event.data() could be null
      final data = event.data() as Map<String, dynamic>;
      final ids = List<String>.from(data["favorites"]);


      context.read<FavoriteBloc>().add(SetFavorite(ids));
    });
  }
  return null;
}
