import 'package:crypto_trends/features/coinInfo/presenter/widgets/custom_inkWell_icon.dart';
import 'package:crypto_trends/ui/icons/icons.dart';
import 'package:flutter/material.dart';

import '../../../../ui/colors/colors.dart';

class CoinInfoPageAppBar extends StatelessWidget {
  const CoinInfoPageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: size.width / 25),
          height: 50,
          child: CustomInkWellIcon(
            onTap: () {},
            child: const PersoIcon(
              icon: PersoIcons.arrowLeft,
              color: AppColors.mainBlack
            ),
          )),
    );
  }
}
