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
        child: const CustomAppBar(title: "Favorite ⭐",),
      ),
    );
  }
}