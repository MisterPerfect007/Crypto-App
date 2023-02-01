import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/features/coinList/presenter/cubit/sorting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../ui/colors/colors.dart';
import '../../cubit/pagination_cubit.dart';

class PaginationExpansionPanel extends StatefulWidget {
  const PaginationExpansionPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<PaginationExpansionPanel> createState() =>
      _PaginationExpansionPanelState();
}

class _PaginationExpansionPanelState extends State<PaginationExpansionPanel> {
  bool _isExpanded = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentPage = context.read<PaginationCubit>().state;
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    return BlocBuilder(
      bloc: context.read<PaginationCubit>(),
      builder: (context, int state) {
        return ExpansionPanelList(
            elevation: 0,
            expansionCallback: ((panelIndex, isExpanded) {
              setState(() {
                _isExpanded = !isExpanded;
              });
            }),
            children: [
              ExpansionPanel(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  isExpanded: _isExpanded,
                  canTapOnHeader: true,
                  headerBuilder: ((context, isExpanded) {
                    return Row(
                      children: [
                        Expanded(child: Container()),
                        Text.rich(TextSpan(
                          children: [
                            const TextSpan(
                              text: "Page: ",
                            ),
                            TextSpan(
                                text: state.toString(),
                                style: const TextStyle(
                                    color: AppColors.mainGreen)),
                            const TextSpan(
                              text: " / 100",
                            ),
                          ],
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              color: AppColors.mainGrey),
                        )),
                        Expanded(child: Container()),
                      ],
                    );
                  }),
                  body: Row(
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
                        width: 80,
                        height: 40,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            dropdownColor: theme.disabledColor,
                            menuMaxHeight: 400,
                            alignment: AlignmentDirectional.center,
                            value: currentPage,
                            items: List<int>.generate(100, (index) => index + 1)
                                .map(
                                  (index) => DropdownMenuItem<int>(
                                      value: index,
                                      child: Text(
                                        index.toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: theme.primaryColor),
                                      )),
                                )
                                .toList(),
                            onChanged: (index) {
                              setState(() {
                                if (index != null) {
                                  currentPage = index;
                                }
                              });
                              // context.read<PaginationCubit>().changePage(index!);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<PaginationCubit>()
                              .changePage(currentPage);
                          //* New data with the current page
                          context.read<CoinListBloc>().add(CoinListGet(
                                page: currentPage,
                                sortingCriteria:
                                    context.read<SortingCubit>().state,
                              ));
                        },
                        child: const Text(
                          "Go",
                          style: TextStyle(color: AppColors.mainGreen),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.mainGreen.withOpacity(0.2),
                            shadowColor: Colors.white.withOpacity(0.1)),
                      )
                    ],
                  ))
            ]);
      },
    );
  }
}
