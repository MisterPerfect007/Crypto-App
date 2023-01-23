import 'package:flutter/material.dart';


class CoinListAppBar extends StatelessWidget {
  const CoinListAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: size.width / 25,
          right: size.width / 25,
        ),
        height: 40,
        child: Row(children: [
           Text(
            "Coins List 📋",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          
        ]),
      ),
    );
  }
}
