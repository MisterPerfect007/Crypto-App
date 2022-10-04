import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
import 'package:crypto_trends/features/home/presenter/bloc/top10/top_10_bloc.dart';
import 'package:crypto_trends/features/home/presenter/bloc/trending_coin/trending_coin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  CurrencyModel selectedCurrency = currenciesList.first;

  bool showReloadButton = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
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
    storeCurrencyLocaly(selectedCurrency);

    // context.read<CoinListBloc>().add(event);
    // context.read<TrendingCoinsBloc>().state;
    // context.read<Top10Bloc>().state;
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
