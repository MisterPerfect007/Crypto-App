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
    // double sidePadding = size.width / 25;
    return Container(
      width: size.width,
      decoration: BoxDecoration(color: AppColors.lightBg, boxShadow: [
        BoxShadow(
            color: AppColors.mainGrey.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 1,
            spreadRadius: 0.2)
      ]),
      // margin: EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(
            androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SingleCriteria(
                name: "Rank",
                isSelected: true,
              ),
              SingleCriteria(
                name: "Price",
                isSelected: false,
              ),
              SingleCriteria(
                name: "% 24h",
                isSelected: false,
              ),
              SingleCriteria(
                name: "% week",
                isSelected: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
