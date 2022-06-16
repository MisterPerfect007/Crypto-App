import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/scrollposition_cubit.dart';
import 'single_criteria.dart';

class SortingCriteria extends StatelessWidget {
  const SortingCriteria({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double sidePadding = size.width / 25;
    
    return BlocBuilder(
      bloc: context.read<ScrollPositionCubit>(),
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: size.width,
          decoration: (context.read<ScrollPositionCubit>().state > 0)
              ? BoxDecoration(
                  color: AppColors.lightBg,
                  boxShadow: [
                    // context.read<ScrollPositionCubit>().state > 0 ?
                    BoxShadow(
                        color: AppColors.mainGrey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 1,
                        spreadRadius: 0.2)
                  ],
                )
              : const BoxDecoration(
                  color: AppColors.lightBg,
                ),
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
      },
    );
  }
}
