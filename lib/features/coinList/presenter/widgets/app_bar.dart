import 'package:flutter/material.dart';

import '../../../../ui/colors/colors.dart';

class CoinPageAppBar extends StatelessWidget {
  const CoinPageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: size.width / 25,
          right: size.width / 25,
        ),
        height: 50,
        child: Row(children: const [
           Text(
            "Coin List",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.pureBlack,
            ),
          ),
          
        ]),
      ),
    );
  }
}
