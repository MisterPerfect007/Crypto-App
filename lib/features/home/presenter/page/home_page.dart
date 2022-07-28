import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto_trends/injection_container.dart' as di;

import '../../../../core/widgets/custom_network_image.dart';
import '../../../coinList/domain/entities/coin.dart';
import '../bloc/trending_coin_bloc.dart';
import '../widgets/top10Coins/top_10_coins.dart';
import '../widgets/top_banner.dart';
import '../widgets/trendingCoins/trending_coins.dart';
import '../widgets/trendingCoins/trending_coins_loaded_widget.dart';
import '../widgets/trendingCoins/trending_coins_loading_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => di.sl<TrendingCoinsBloc>()))
        ],
        child: Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            color: AppColors.lightBg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopBanner(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TrendingCoins(),
                        Top10Coins()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}





