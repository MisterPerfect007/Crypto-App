import 'package:crypto_trends/features/coinList/presenter/widgets/sorting%20criteria/criteria_list.dart';
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
          height: 55,
          width: size.width,
          decoration: (context.read<ScrollPositionCubit>().state > 0)
              ? BoxDecoration(
                  color: AppColors.lightBg,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.mainGrey.withOpacity(0.1),
                        offset: const Offset(0, 1),
                        blurRadius: 0.5,
                        spreadRadius: 0),
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
            behavior: const ScrollBehavior(),
            child: ListView.builder(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              scrollDirection: Axis.horizontal,
              itemCount: criteriaList.length,
              itemBuilder: ((context, index) {
                return SingleCriteria(
                  name: criteriaList[index]["by"],
                  desc: criteriaList[index]["desc"],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
