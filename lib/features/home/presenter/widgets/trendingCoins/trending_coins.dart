import 'dart:async';

import 'package:crypto_trends/errors/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/widgets/errors/error_message.dart';
import '../../../../../ui/icons/svg_icons.dart';
import '../../bloc/trending_coin/trending_coin_bloc.dart';
import 'build_see_all.dart';
import 'trending_coins_loaded_widget.dart';
import 'trending_coins_loading_widget.dart';

class TrendingCoins extends StatefulWidget {
  const TrendingCoins({
    Key? key,
  }) : super(key: key);

  @override
  State<TrendingCoins> createState() => _TrendingCoinsState();
}

class _TrendingCoinsState extends State<TrendingCoins> {
  @override
  void initState() {
    super.initState();
    gettingTrendingCoins(context);
    Timer.periodic(const Duration(seconds: 60), (_) {
      refreshTop10List(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;

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
                    color: Theme.of(context).primaryColor,
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
            if (state is TrendingCoinsLoading ||
                state is TrendingCoinsInitial) {
              return const TrendingCoinsLoadingWidget();
            } else if (state is TrendingCoinsLoaded) {
              return TrendingCoinsLoadedWidget(coinList: state.coinList);
            } else if (state is TrendingCoinsFailure) {
              if (state.errorType == ErrorType.noInternetConnection) {
                return CustomErrorWidget(
                  msg: 'No internet',
                  icon: SvgIcons.noWifiLine,
                  onPressed: () async {
                    if (await InternetConnectionChecker().hasConnection) {
                      gettingTrendingCoins(context);
                    } else {
                      Fluttertoast.showToast(
                          msg: "You still Offline",
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: theme.primaryColor,
                          textColor: theme.scaffoldBackgroundColor);
                    }
                  },
                );
              }
            }
            return CustomErrorWidget(
              msg: 'Something went wrong',
              icon: SvgIcons.badO,
              onPressed: () async {
                gettingTrendingCoins(context);
              },
            );
          },
        ),
      ]),
    );
  }
}

void gettingTrendingCoins(BuildContext context) {
  final trendingBloc = context.read<TrendingCoinsBloc>();
  trendingBloc.add(GetTrendingCoins());
}

void refreshTop10List(BuildContext context) {
  final top10Bloc = context.read<TrendingCoinsBloc>();
  final state = top10Bloc.state;
  if (state is TrendingCoinsLoaded) {
    top10Bloc.add(RefreshTrendingCoins());
  }
}
