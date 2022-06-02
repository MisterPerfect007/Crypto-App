// Mocks generated by Mockito 5.2.0 from annotations
// in crypto_trends/test/features/coinInfo/domain/usecases/get_coin_market_chart_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:crypto_trends/errors/failures.dart' as _i5;
import 'package:crypto_trends/features/coinInfo/domain/entities/coin_market_chart.dart'
    as _i6;
import 'package:crypto_trends/features/coinInfo/domain/repository/get_coin_market_chart_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
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

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [GetCoinMarketChartRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCoinMarketChartRepository extends _i1.Mock
    implements _i3.GetCoinMarketChartRepository {
  MockGetCoinMarketChartRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.CoinMarketChart>>
      getRemoteCoinMarketChart(
              {String? id,
              String? currency,
              String? days,
              bool? dailyInterval}) =>
          (super.noSuchMethod(
                  Invocation.method(#getRemoteCoinMarketChart, [], {
                    #id: id,
                    #currency: currency,
                    #days: days,
                    #dailyInterval: dailyInterval
                  }),
                  returnValue:
                      Future<_i2.Either<_i5.Failure, _i6.CoinMarketChart>>.value(
                          _FakeEither_0<_i5.Failure, _i6.CoinMarketChart>()))
              as _i4.Future<_i2.Either<_i5.Failure, _i6.CoinMarketChart>>);
}
