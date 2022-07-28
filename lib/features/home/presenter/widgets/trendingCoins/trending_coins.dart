import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import '../../bloc/trending_coin_bloc.dart';
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
      child: 
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              Text(
                "See all",
                style: GoogleFonts.inter(
                    color: AppColors.mainGreen,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
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
            }
            return Container();
          },
        ),
      ]),
    );
  }
}
