import 'package:flutter/material.dart';

import '../../../../../ui/colors/colors.dart';

class SingleCriteria extends StatelessWidget {
  const SingleCriteria({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
                color: AppColors.secondGrey,
                offset: Offset(0, 1),
                blurRadius: 0.5,
                spreadRadius: 0.2),
          ]),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          splashColor: AppColors.secondGreen,
          onTap: () {},
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 7,
              bottom: 7,
            ),
            child: const Text(
              'Rank',
              style: TextStyle(
                  color: AppColors.mainGrey, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
