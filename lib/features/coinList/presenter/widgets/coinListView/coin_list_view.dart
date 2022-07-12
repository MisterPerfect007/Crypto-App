import 'package:flutter/material.dart';

import '../../../domain/entities/coin.dart';
import '../single coin/single_coin.dart';
import 'custom_expansion_panel.dart';

class CoinListView extends StatefulWidget {
  const CoinListView({
    Key? key,
    required ScrollController scrollController,
    required this.coinList,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List<Coin> coinList;

  @override
  State<CoinListView> createState() => _CoinListViewState();
}

class _CoinListViewState extends State<CoinListView> {
  double _opacity = 0;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _opacity = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _opacity,
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: widget._scrollController,
          padding: const EdgeInsets.only(bottom: 70),
          itemCount: (widget.coinList.length + 1),
          itemBuilder: ((context, i) {
            final coinList = widget.coinList;
            //To be able to put pagination widget to the top of listview
            i--;
            if (i == -1) {
              return const PaginationExpansionPanel();
            } else {
              return SingleCoin(
                id: coinList[i].id,
                name: coinList[i].name,
                image: coinList[i].image,
                symbol: coinList[i].symbol,
                currentPrice: coinList[i].currentPrice,
                marketCapRank: coinList[i].marketCapRank,
                priceChangePercentage7dInCurrency:
                    coinList[i].priceChangePercentage7dInCurrency,
                lastWeekData: coinList[i].sparklineIn7d?.price,
              );
            }
          })),
    );
  }
}
