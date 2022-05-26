import 'package:flutter/material.dart';

import '../../../../ui/colors/colors.dart';
import '../../../../ui/icons/icons.dart';

class CoinPageAppBar extends StatelessWidget {
  const CoinPageAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: size.width / 25,
          right: size.width / 25,
        ),
        height: 50,
        child: Row(children: [
          const Text(
            "Coin List",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.mainBlack),
          ),
          Expanded(child: Container()),
          InkWell(
            splashColor: const Color.fromARGB(255, 199, 199, 199),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondGreen,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(6),
              child: const PersoIcon(
                icon: PersoIcons.searchMd,
                color: AppColors.mainGreen,
                size: 25,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            splashColor: const Color.fromARGB(255, 199, 199, 199),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const PersoIcon(
                icon: PersoIcons.more,
                color: AppColors.mainBlack,
                size: 17,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}