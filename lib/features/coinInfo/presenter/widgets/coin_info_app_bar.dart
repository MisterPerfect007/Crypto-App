import 'package:crypto_trends/features/coinInfo/presenter/widgets/custom_ink_well_icon.dart';
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
        color: AppColors.lightBg,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: size.width / 25),
        child: Row(
          children: [
            CustomInkWellIcon(
              onTap: () {},
              size: 47,
              radius: 47,
              child: const PersoIcon(
                icon: PersoIcons.arrowLeft,
                color: AppColors.mainBlack,
                // size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
