import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/features/coinList/presenter/pages/sample_data.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/app_bar.dart';
import '../widgets/single coin/single_coin.dart';
import '../widgets/sorting criteria/sorting_criteria.dart';

class CoinListPage extends StatelessWidget {
  const CoinListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context.read<CoinListBloc>().add(const GetCoinList(currency: "usd", page: 2));
    // double sidePadding = size.width / 25;
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          100,
        ),
        child: CoinPageAppBar(size: size),
      ),
      body: SizedBox(
          height: size.height,
          child: BlocBuilder<CoinListBloc, CoinListState>(
            builder: ((context, state) {
            if (state is CoinListInitial) {
              return const Text('Initial state');
            } else if (state is CoinListLoading) {
              return const Align(child: const CircularProgressIndicator());
            } else if (state is CoinListLoaded) {
              List<Coin> coinList = state.coinList;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SortingCriteria(),
                    Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 100),
                            itemCount: coinList.length,
                            itemBuilder: ((context, i) {
                              return SingleCoin(
                                name: coinList[i].name,
                                image: coinList[i].image,
                                symbol: coinList[i].symbol,
                                currentPrice: coinList[i].currentPrice,
                                marketCapRank: coinList[i].marketCapRank,
                                priceChangePercentage7dInCurrency: coinList[i]
                                    .priceChangePercentage7dInCurrency,
                                lastWeekData:
                                    coinList[i].sparklineIn7d?.price,
                              );
                            })))
                  ]);
            } else {
              return const Text('Something went wrong');
            }
          }))
          // Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisSize: MainAxisSize.max,
          //     children: [
          //       const SortingCriteria(),
          //       Expanded(child: ListView.builder(
          //         padding: const EdgeInsets.only(bottom: 100),
          //         itemCount: 20,
          //         itemBuilder: ((context, index) {
          //         return const SingleCoin(
          //           name: 'Bitcoin',
          //           image:
          //               'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
          //           symbol: 'btc',
          //           currentPrice: 930984.99,
          //           marketCapRank: 1,
          //           priceChangePercentage7dInCurrency: 9.1287,
          //           lastWeekData: weekData,
          //         );
          //       })))
          //     ]),
          ),
    );
  }
}
/* 
SingleCoin(
                      name: 'Bitcoin',
                      image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
                      symbol: 'btc',
                      currentPrice: 930984.99,
                      marketCapRank: 1,
                      priceChangePercentage7dInCurrency: 9.1287,
                      lastWeekData: weekData,
                    ),
                    SingleCoin(
                      name: 'Ethereum eth',
                      image: 'https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880',
                      symbol: 'btc',
                      currentPrice: 1.82,
                      marketCapRank: 1,
                      priceChangePercentage7dInCurrency: 19.1287,
                      lastWeekData: weekData,
                    ),
      */