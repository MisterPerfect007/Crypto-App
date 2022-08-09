import 'package:crypto_trends/core/widgets/errors/failed_request.dart';
import 'package:crypto_trends/errors/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import '../../bloc/trending_coin/trending_coin_bloc.dart';
import 'build_see_all.dart';
import 'trending_coins_loaded_widget.dart';
import 'trending_coins_loading_widget.dart';

class TrendingCoins extends StatelessWidget {
  const TrendingCoins({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    context.read<TrendingCoinsBloc>().add(GetTrendingCoins());
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
          child: Row(
            children: [
              Text(
                "Trending Coins",
                style: GoogleFonts.inter(
                    color: AppColors.mainBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              Expanded(child: Container()),
              buildSeeAll(sidePadding)
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<TrendingCoinsBloc, TrendingCoinsState>(
          builder: (context, state) {
            //! Loading
            if (state is TrendingCoinsLoading) {
              return const TrendingCoinsLoadingWidget();
            } else if (state is TrendingCoinsLoaded) {
              //!!!!!!!!!!!!!!!!!!!!! CoinList > 4 !!!!!!!!!!!!!
              return TrendingCoinsLoadedWidget(coinList: state.coinList);
            } else if (state is TrendingCoinsFailure) {
              if (state.errorType == ErrorType.noInternetConnection) {
                return FailedRequest(
                  small: true,
                  icon: PersoIcons.coloredNoWifi,
                  title: "You're currently offline",
                  secondTitle:
                      "Check your internet connection and try to refresh.",
                  buttonOnPressed: () {
                    // gettingOrRefringCoinList(context);
                  },
                  buttonText: "Refresh",
                );
              }
            }
            return FailedRequest(
              small: true,
              icon: PersoIcons.coloredRemove,
              title: "Something went wrong",
              secondTitle:
                  "Something went wrong on the back side, please try again.",
              buttonOnPressed: () {
                // gettingOrRefringCoinList(context);
              },
              buttonText: "Try again",
            );
          },
        ),
      ]),
    );
  }
}
