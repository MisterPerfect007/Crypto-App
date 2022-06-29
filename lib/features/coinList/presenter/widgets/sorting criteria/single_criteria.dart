import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import '../../bloc/coin_list_bloc.dart';
import '../../cubit/sorting_cubit.dart';

class SingleCriteria extends StatelessWidget {
  const SingleCriteria({
    Key? key,
    required this.name,
    required this.desc,
  }) : super(key: key);

  final String name;
  final bool desc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<SortingCubit>(),
      builder: (context, Map<String, dynamic> state) {
        bool isDesc = false;
        bool isSelected = false;
        // if(context.read<CoinListBloc>().state is CoinListLoaded){
        //   final stat = context.read<CoinListBloc>().state;
        //   print("Can caallll>>$statŸ");
        // };
        // .add(const CoinListUpdate(currency: "usd", page: 1));
        if (state["by"] == name) {
          isSelected = true;
          isDesc = state["desc"];
        }
        return Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.mainGreen.withOpacity(0.1)
                  : AppColors.mainWhite,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              boxShadow: isSelected
                  ? null
                  : [
                      const BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 1,
                          color: AppColors.secondGrey),
                    ]),
          child: Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: InkWell(
              splashColor: AppColors.secondGreen,
              onTap: () {
                //! to be Extracted
                final coinListState = context.read<CoinListBloc>().state;
                if (coinListState is CoinListLoaded) {
                  final coinList = coinListState.coinList;
                  context
                      .read<SortingCubit>()
                      .changeSorting({"by": name, "desc": isDesc});
                  final criteria = context.read<SortingCubit>().state;
                  context.read<CoinListBloc>().add(
                      CoinListSorting(coinList: coinList, criteria: criteria));
                }
              },
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
                child: Row(
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isSelected
                            ? AppColors.mainGreen
                            : AppColors.mainGrey,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                    isSelected
                        ? Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: RotatedBox(
                              quarterTurns: (isSelected && !isDesc) ? 0 : 2,
                              child: const PersoIcon(
                                icon: PersoIcons.arrowUp1,
                                size: 10,
                              ),
                            ))
                        : Container()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
