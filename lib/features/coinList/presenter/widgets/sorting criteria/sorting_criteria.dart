import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';

import 'single_criteria.dart';

class SortingCriteria extends StatelessWidget {
  const SortingCriteria({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
      decoration: BoxDecoration(color: AppColors.lightBg, boxShadow: [
        BoxShadow(
          color: AppColors.pureBlack.withOpacity(0.1),
          offset: Offset(0, 10),
          blurRadius: 5,
          spreadRadius: 1
        )
      ]),
      // margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(
        left: sidePadding,
        right: sidePadding,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SingleCriteria(),
            SingleCriteria(),
            SingleCriteria(),
            SingleCriteria(),
            SingleCriteria(),
            SingleCriteria(),
            SingleCriteria(),
            SingleCriteria(),
          ],
        ),
      ),
    );
  }
}
