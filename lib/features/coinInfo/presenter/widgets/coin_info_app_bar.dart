import 'package:crypto_trends/features/search/presenter/widgets/search_app_bar.dart';
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
                color: AppColors.mainGrey.withOpacity(0.1),
                offset: const Offset(0, 1),
                blurRadius: 0.5,
                spreadRadius: 0),
          ],
        ),
        child: Row(
          children: const [GoBack()],
        ),
      ),
    );
  }
}
