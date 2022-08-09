import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_trends/injection_container.dart' as di;

import '../../../coinList/presenter/bloc/coin_list_bloc.dart';
import '../../../coinList/presenter/cubit/sorting_cubit.dart';
import '../bloc/trending_coin/trending_coin_bloc.dart';
import '../widgets/top10Coins/top_10_coins.dart';
import '../widgets/top_banner.dart';
import '../widgets/trendingCoins/trending_coins.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => di.sl<TrendingCoinsBloc>())),
          BlocProvider(create: ((context) => di.sl<CoinListBloc>())),
          BlocProvider(create: ((context) => SortingCubit())),
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
                      children: const [
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





