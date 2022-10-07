import 'package:flutter/material.dart';

import '../../../../core/widgets/navigation/go_back_widget.dart';
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
