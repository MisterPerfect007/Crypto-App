import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_trends/core/widgets/appBar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          50,
        ),
        child: const CustomAppBar(
          title: "Favorite ⭐",
        ),
      ),
      body: Center(
        child: FavoriteInfo(),
      ),
    );
  }
}

class FavoriteInfo extends StatefulWidget {
  const FavoriteInfo({Key? key}) : super(key: key);

  @override
  _FavoriteInfoState createState() => _FavoriteInfoState();
}

class _FavoriteInfoState extends State<FavoriteInfo> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('favorite').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return const Text("Loaded");
      },
    );
  }
}
