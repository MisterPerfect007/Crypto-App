import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import '../../cubit/pagination_cubit.dart';

class PaginationExpansionPanel extends StatefulWidget {
  const PaginationExpansionPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<PaginationExpansionPanel> createState() => _PaginationExpansionPanelState();
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
                                text: currentPage.toString(),
                                style: const TextStyle(
                                    color: AppColors.mainGreen)),
                            const TextSpan(
                              text: " / 100",
                            ),
                          ],
                          style: GoogleFonts.inter(
                              fontSize: 13, color: AppColors.mainGrey),
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
                        width: 60,
                        height: 40,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            menuMaxHeight: 300,
                            alignment: AlignmentDirectional.center,
                            value: state,
                            items: List<int>.generate(100, (index) => index + 1)
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
                  ))
            ]);
      },
    );
  }
}
