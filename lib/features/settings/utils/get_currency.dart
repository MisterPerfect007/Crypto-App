
import 'dart:convert';

import 'package:crypto_trends/core/localStorage/local_storage_key_value.dart';
import 'package:crypto_trends/features/settings/data/models/currency_model.dart';
import 'package:crypto_trends/features/settings/utils/currencies.dart';
import 'package:crypto_trends/injection_container.dart' as di;

import '../../../core/localStorage/keys.dart';

final localStorage = di.sl<LocalStorageKeyValue>();

///Set [currency] to local storage
Future<bool> storeCurrencyLocaly(CurrencyModel currency) async {
  return localStorage.setString(currencyKey, currency.json().toString());
}

///Get the currency stored if there is 
CurrencyModel? getCurrencyFromStorage(){
  final String? currencyString = localStorage.getString(currencyKey);
  if (currencyString != null) {
    final currencyJson = Map<String, dynamic>.from(jsonDecode(currencyString));
    return CurrencyModel.fromJson(currencyJson);
  }
  return null;
}

///Should return the stored currency or first one on currencies list (USD)
CurrencyModel getCurrentCurrency(){
  return getCurrencyFromStorage() ?? currenciesList.first;
}