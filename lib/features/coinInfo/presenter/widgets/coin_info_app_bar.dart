import 'package:crypto_trends/features/coinInfo/presenter/widgets/custom_ink_well_icon.dart';
import 'package:crypto_trends/ui/icons/icons.dart';
import 'package:flutter/material.dart';

import '../../../../ui/colors/colors.dart';

class CoinInfoPageAppBar extends StatelessWidget {
  const CoinInfoPageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.lightBg,
          boxShadow: [
            BoxShadow(
                color: AppColors.mainGrey.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 1,
                spreadRadius: 0.2)
          ],
        ),
        child: Row(
          children: [
            CustomInkWellIcon(
              onTap: () {
                Navigator.pop(context);
              },
              size: 47,
              radius: 47,
              child: const PersoIcon(
                icon: PersoIcons.arrowLeft,
                color: AppColors.mainBlack,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
