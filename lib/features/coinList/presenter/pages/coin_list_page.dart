import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/features/coinList/presenter/cubit/pagination_cubit.dart';
import 'package:crypto_trends/features/coinList/presenter/cubit/sorting_cubit.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:crypto_trends/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/errors/failed_request.dart';
import '../../../../errors/error_types.dart';
import '../cubit/scrollposition_cubit.dart';
import '../utils/utils_functions.dart';
import '../widgets/app_bar.dart';
import '../widgets/coin_list_shimmer.dart';
import '../widgets/coinListView/coin_list_view.dart';
import '../widgets/customFloatingActionButton/custom_floating_action_button.dart';
import '../widgets/sorting criteria/sorting_criteria.dart';

class CoinListPage extends StatelessWidget {
  const CoinListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    gettingOrRefringCoinList(context);
    final ScrollController _scrollController = ScrollController();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          100,
        ),
        child: const CoinPageAppBar(),
      ),
      floatingActionButton:
          CustomSpeedDial(scrollController: _scrollController),
      body: SizedBox(
        height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SortingCriteria(),
            Expanded(
              child: BlocBuilder<CoinListBloc, CoinListState>(
                  builder: ((context, state) {
                /*
                    !CoinListInitial
                   */
                if (state is CoinListInitial) {
                  return const Text('Initial state');
                } else if (state is CoinListLoading) {
                  /*
                    !CoinListLoading 
                   */
                  return const SizedBox(
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior(
                        androidOverscrollIndicator:
                            AndroidOverscrollIndicator.stretch,
                      ),
                      child: CoinShimmer(),
                    ),
                  );
                } else if (state is CoinListLoaded) {
                  /*
                    !CoinListLoaded
                   */
                  return ScrollConfiguration(
                    behavior: const ScrollBehavior(
                        androidOverscrollIndicator:
                            AndroidOverscrollIndicator.stretch),
                    child: NotificationListener(
                      onNotification: ((notification) {
                        context
                            .read<ScrollPositionCubit>()
                            .onScroll(_scrollController.position.pixels);
                        return true;
                      }),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await gettingOrRefringCoinList(context);
                        },
                        color: AppColors.mainGreen,
                        child: CoinListView(
                          scrollController: _scrollController,
                          coinList: state.coinList,
                        ),
                      ),
                    ),
                  );
                  /* 
                    !CoinListFailure
                   */
                } else if (state is CoinListFailure) {
                  if (state.errorType == ErrorType.noInternetConnection) {
                    return FailedRequest(
                      icon: PersoIcons.coloredNoWifi,
                      title: "You're currently offline",
                      secondTitle:
                          "Check your internet connection and try to refresh.",
                      buttonOnPressed: () {
                        context.read<CoinListBloc>().add(CoinListGet(
                              currency: "usd",
                              page: (context.read<PaginationCubit>().state),
                              sortingCriteria: context.read<SortingCubit>().state,
                            ));
                      },
                      buttonText: "Refresh",
                    );
                  } else {
                    return FailedRequest(
                      icon: PersoIcons.coloredRemove,
                      title: "Something went wrong",
                      secondTitle:
                          "Something went wrong on the back side, please try again.",
                      buttonOnPressed: () {},
                      buttonText: "Try again",
                    );
                  }
                } else {
                  return FailedRequest(
                    icon: PersoIcons.coloredRemove,
                    title: "Something went wrong",
                    secondTitle:
                        "Something went wrong on the back side, please try again.",
                    buttonOnPressed: () {},
                    buttonText: "Try again",
                  );
                }
              })),
            ),
          ],
        ),
      ),
    );
  }
}
