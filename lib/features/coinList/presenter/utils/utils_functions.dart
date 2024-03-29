import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/coin.dart';
import '../bloc/coin_list_bloc.dart';
import '../cubit/pagination_cubit.dart';
import '../cubit/sorting_cubit.dart';

//* Tested
double? calculate7DPercentage(List<double>? lastWeekData) {
  if (lastWeekData != null && lastWeekData.isNotEmpty) {
    return double.parse((100 *
            (lastWeekData[lastWeekData.length - 1] - lastWeekData[0]) /
            lastWeekData[0])
        .toStringAsFixed(5));
  } else {
    return null;
  }
}


///Sort the [coinList] according to the given [criteria]
///
//*Tested
List<Coin> sortCoinList(
    {required List<Coin> coinList, required Map<String, dynamic> criteria}) {
  List<Coin> newCoinList = List<Coin>.from(coinList);

  double smallestDouble = -10000;

  switch (criteria["by"]) {
    case "Rank":
      newCoinList.sort(
          (a, b) => (b.marketCapRank ?? 0).compareTo((a.marketCapRank ?? 0)));
      break;
    case "Price":
      newCoinList.sort((a, b) => (a.currentPrice ?? smallestDouble)
          .compareTo((b.currentPrice ?? smallestDouble)));
      break;
    case "% 24h":
      newCoinList.sort((a, b) => (a.priceChangePercentage24h ?? smallestDouble)
          .compareTo((b.priceChangePercentage24h ?? smallestDouble)));
      break;
    case "% 7d":
      newCoinList.sort((a, b) => (a.priceChangePercentage7dInCurrency ??
              smallestDouble)
          .compareTo(b.priceChangePercentage7dInCurrency ?? smallestDouble));
      break;
    case "Name":
      newCoinList
          .sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
      break;
  }
  if (criteria["desc"]) {
    return newCoinList.reversed.toList();
  }
  return newCoinList;
}


void gettingOrRefringCoinList(BuildContext context) {
  final coinListBloc = context.read<CoinListBloc>();
  final criteria = context.read<SortingCubit>().state;
  final state = coinListBloc.state;
  final int pageToFetch = context.read<PaginationCubit>().state;
  if (state is CoinListLoaded) {
    coinListBloc.add(CoinListUpdate(page: pageToFetch, sortingCriteria: criteria));
  } else if (state is! CoinListLoading) {
    coinListBloc.add(CoinListGet(page: pageToFetch, sortingCriteria: criteria));
  }
}
