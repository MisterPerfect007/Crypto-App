import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../coinList/presenter/bloc/coin_list_bloc.dart';
import '../../../../coinList/presenter/cubit/pagination_cubit.dart';
import '../../../../coinList/presenter/cubit/sorting_cubit.dart';
import '../../../../favorites/controllers/get/favorite_controller.dart';
import '../../../../favorites/presenter/bloc/favorite_list_bloc.dart';
import '../../../../home/presenter/bloc/top10/top_10_bloc.dart';
import '../../../../home/presenter/bloc/trending_coin/trending_coin_bloc.dart';
import '../../../data/models/currency_model.dart';
import '../../../utils/currencies.dart';
import '../../../utils/get_currency.dart';

class CurrencyDropdown extends StatefulWidget {
  const CurrencyDropdown({
    Key? key,
  }) : super(key: key);

  @override
  State<CurrencyDropdown> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  //
  final currencyStorage = CurrencyStorage();
  CurrencyModel selectedCurrency = CurrencyStorage().getCurrentCurrency();

  bool showReloadButton = false;

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
                color: theme.disabledColor,
                border: Border.all(color: theme.primaryColor),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: theme.disabledColor,
                isDense: true,
                menuMaxHeight: 300,
                alignment: AlignmentDirectional.center,
                value: selectedCurrency.shortName,
                items: currenciesList
                    .map((currency) => DropdownMenuItem<String>(
                          alignment: AlignmentDirectional.center,
                          value: currency.shortName,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(currency.image, width: 20),
                                const SizedBox(width: 10),
                                Text(
                                  currency.fullName,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  currency.shortName,
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 9,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                )
                              ]),
                        ))
                    .toList(),
                onChanged: handleCurrencyChange,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          showReloadButton
              ? ElevatedButton(
                  onPressed: handleReloadData, child: const Text("Reload data"))
              : Container()
        ],
      ),
    );
  }

  void handleReloadData() {
    //store the currency localy
    currencyStorage.storeCurrencyLocaly(selectedCurrency);

    //! Update coin list
    final int pageToFetch = context.read<PaginationCubit>().state;
    final coinListBloc = context.read<CoinListBloc>();
    final criteria = context.read<SortingCubit>().state;

    coinListBloc.add(CoinListGet(page: pageToFetch, sortingCriteria: criteria));

    //! Update top 10 coins on home page
    final top10Bloc = context.read<Top10Bloc>();
    top10Bloc.add(const GetTop10Coins(page: 1, perPage: 100));

    //! Update trending coin
    final trendingBloc = context.read<TrendingCoinsBloc>();
    trendingBloc.add(GetTrendingCoins());

    //! Update favorite list
    final favoriteBloc = context.read<FavoriteListBloc>();
    final FavoriteController favoriteController = Get.put(FavoriteController());
    if (favoriteController.favorites.isNotEmpty) {
      favoriteBloc.add(GetFavoriteList(favoriteController.favorites));
    }

    //dismiss the button
    setState(() {
      showReloadButton = false;
    });
  }

  void handleCurrencyChange(currencyShortName) {
    if (currencyShortName != null) {
      if (currencyShortName != selectedCurrency.shortName) {
        setState(() {
          selectedCurrency = currenciesList
              .firstWhere((c) => c.shortName == currencyShortName);
          showReloadButton = true;
        });
      }
    }
  }
}
