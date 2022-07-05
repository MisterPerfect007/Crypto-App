import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import '../../cubit/pagination_cubit.dart';

class CustomExpansionPanel extends StatefulWidget {
  const CustomExpansionPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomExpansionPanel> createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel> {
  bool isExpanded = false;
  bool showedExpanded = false;
  int currentPage = 1;
  
  @override
  void initState(){
    super.initState();
    setState(() {
      currentPage = context.read<PaginationCubit>().state;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width / 25;
    return BlocBuilder(
      bloc: context.read<PaginationCubit>(),
      builder: (context, int state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
          height: isExpanded ? 80 : 22,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                  await Future.delayed(const Duration(milliseconds: 300), () {
                    setState(() {
                      showedExpanded = !showedExpanded;
                    });
                  });
                },
                child: Row(
                    children: [
                      Expanded(child: Container()),
                      Text.rich(TextSpan(
                        children: [
                          const TextSpan(
                            text: "Page: ",
                          ),
                          TextSpan(
                              text: currentPage.toString(),
                              style: const TextStyle(color:  AppColors.mainGreen)),
                          const TextSpan(
                            text: " / 100",
                          ),
                        ],
                        style: GoogleFonts.inter(
                            fontSize: 13, color: AppColors.mainGrey),
                      )),
                      const SizedBox(width: 100),
                      RotatedBox(
                          quarterTurns: isExpanded ? 0 : 2,
                          child: const PersoIcon(
                            icon: PersoIcons.angleSmallUp,
                            color: AppColors.mainGrey,
                          )),
                      Expanded(child: Container()),
                    ],
                  ),
              ),
              // const SizedBox(height: 20,),
              if (isExpanded && showedExpanded)
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.mainGreen.withOpacity(0.5),
                                width: 2,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          width: 60,
                          height: 40,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              menuMaxHeight: 300,
                              alignment: AlignmentDirectional.center,
                              value: state,
                              items:
                                  List<int>.generate(100, (index) => index + 1)
                                      .map(
                                        (index) => DropdownMenuItem<int>(
                                            value: index,
                                            child: Text(index.toString())),
                                      )
                                      .toList(),
                              onChanged: (index) {
                                context
                                    .read<PaginationCubit>()
                                    .changePage(index!);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            //* New data with the current page
                            context
                                .read<CoinListBloc>()
                                .add(CoinListGet(currency: "usd", page: state));
                          },
                          child: const Text(
                            "Go",
                            style: TextStyle(color: AppColors.mainGreen),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.mainGreen.withOpacity(0.2),
                              shadowColor: Colors.white.withOpacity(0.1)),
                        )
                      ],
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
