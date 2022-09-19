import 'dart:async';

import 'package:animations/animations.dart';
import 'package:crypto_trends/features/coinList/presenter/pages/coin_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../../core/widgets/errors/failed_request.dart';
import '../../../../../errors/error_types.dart';
import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import '../../../../coinInfo/presenter/page/coin_info.dart';
import '../../../../coinList/domain/entities/coin.dart';
import '../../bloc/top10/top_10_bloc.dart';
import 'build_see_all.dart';
import 'top_10_coin_cart.dart';

void gettingTop10List(BuildContext context) {
  final top10Bloc = context.read<Top10Bloc>();
  top10Bloc.add(const GetTop10Coins(page: 1, currency: "usd", perPage: 100));
}

void refreshTop10List(BuildContext context) {
  final top10Bloc = context.read<Top10Bloc>();
  final state = top10Bloc.state;
  if (state is Top10Loaded) {
    top10Bloc.add(const RefreshTop10Coins(page: 1, currency: "usd", perPage: 100));
  }
}

class Top10Coins extends StatefulWidget {
  const Top10Coins({
    Key? key,
  }) : super(key: key);

  @override
  State<Top10Coins> createState() => _Top10CoinsState();
}

class _Top10CoinsState extends State<Top10Coins> {

  @override
  void initState() {
    super.initState();
    
    Timer.periodic(const Duration(seconds: 60), (_) {
      refreshTop10List(context);
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CoinListPage()));
                },
                child: Text(
                  "Top 10 Coins",
                  style: GoogleFonts.inter(
                      color: AppColors.mainBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              Expanded(child: Container()),
              buildTop10SeeAll(sidePadding),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<Top10Bloc, Top10State>(
          builder: (context, state) {
            if (state is Top10Loading) {
              return Padding(
                padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
                child: Row(children: [
                  Column(children: const [
                    Top10CoinCart(isLoading: true),
                    Top10CoinCart(isLoading: true),
                  ]),
                  SizedBox(width: sidePadding),
                  Column(children: const [
                    Top10CoinCart(isLoading: true),
                    Top10CoinCart(isLoading: true),
                  ]),
                ]),
              );
            } else if (state is Top10Loaded) {
              List<Coin> coinList = state.coinList;
              
              //To be sure that coin list is sorted by marketCapRank
              coinList.sort((a, b) {
                if(a.marketCapRank != null && b.marketCapRank != null){
                  return a.marketCapRank!.compareTo(b.marketCapRank!);
                }else{
                  return 0;
                }
              });

              return CustomOpacityAnimation(
                  child: Padding(
                padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: sidePadding,
                  mainAxisSpacing: sidePadding,
                  children: List.generate(
                    4,
                    (index) => OpenContainer(
                      closedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      closedElevation: 1,
                      closedBuilder: (context, action) =>
                          Top10CoinCart(coin: coinList[index], action: action),
                      openBuilder: (context, action) =>
                          CoinInfoPage(coin: coinList[index], id: '',),
                    ),
                  ),
                ),
              ));
            } else if (state is Top10Failure) {
              if (state.errorType == ErrorType.noInternetConnection) {
                return FailedRequest(
                  small: true,
                  icon: PersoIcons.coloredNoWifi,
                  title: "You're currently offline",
                  secondTitle:
                      "Check your internet connection and try to refresh.",
                  buttonOnPressed: () {
                    gettingTop10List(context);
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
                gettingTop10List(context);
              },
              buttonText: "Try again",
            );
          },
        )
      ]),
    );
  }
}
