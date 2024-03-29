// Mocks generated by Mockito 5.2.0 from annotations
// in crypto_trends/test/features/coinInfo/data/repositories/get_coin_market_chart_repository_implementation_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:crypto_trends/features/coinInfo/data/datasources/coin_market_chart_remote_data_source.dart'
    as _i5;
import 'package:crypto_trends/features/coinInfo/data/models/coin_market_chart_model.dart'
    as _i4;
import 'package:crypto_trends/features/settings/utils/get_currency.dart' as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeClient_0 extends _i1.Fake implements _i2.Client {}

class _FakeCurrencyStorage_1 extends _i1.Fake implements _i3.CurrencyStorage {}

class _FakeCoinMarketChartModel_2 extends _i1.Fake
    implements _i4.CoinMarketChartModel {}

/// A class which mocks [CoinMarketChartRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockCoinMarketChartRemoteDataSourceImpl extends _i1.Mock
    implements _i5.CoinMarketChartRemoteDataSourceImpl {
  MockCoinMarketChartRemoteDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get client => (super.noSuchMethod(Invocation.getter(#client),
      returnValue: _FakeClient_0()) as _i2.Client);
  @override
  _i3.CurrencyStorage get currencyStorage =>
      (super.noSuchMethod(Invocation.getter(#currencyStorage),
          returnValue: _FakeCurrencyStorage_1()) as _i3.CurrencyStorage);
  @override
  Map<String, String> get defaultHeader =>
      (super.noSuchMethod(Invocation.getter(#defaultHeader),
          returnValue: <String, String>{}) as Map<String, String>);
  @override
  _i6.Future<_i4.CoinMarketChartModel> getRemote(
          {String? id, String? days, bool? dailyInterval}) =>
      (super.noSuchMethod(
              Invocation.method(#getRemote, [],
                  {#id: id, #days: days, #dailyInterval: dailyInterval}),
              returnValue: Future<_i4.CoinMarketChartModel>.value(
                  _FakeCoinMarketChartModel_2()))
          as _i6.Future<_i4.CoinMarketChartModel>);
}
