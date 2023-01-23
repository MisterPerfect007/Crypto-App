import 'package:crypto_trends/core/widgets/animation/custom_opacity_animation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/favorites_utils.dart';
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
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return CustomOpacityAnimation(
      duration: const Duration(milliseconds: 500),
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
                coin: coinList[i],
                onFavoriteTap: () async => await addOrRemoveFavorite(context, coinList[i].id),
              );
            }
          })),
    );
  }
  
}
