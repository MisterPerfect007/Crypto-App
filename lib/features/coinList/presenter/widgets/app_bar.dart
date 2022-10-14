import 'package:flutter/material.dart';


class CoinPageAppBar extends StatelessWidget {
  const CoinPageAppBar({
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
        height: 50,
        child: Row(children: [
           Text(
            "Coin List 📋",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          
        ]),
      ),
    );
  }
}
