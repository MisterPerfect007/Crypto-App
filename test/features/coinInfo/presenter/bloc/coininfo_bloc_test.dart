import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_trends/features/coinInfo/domain/entities/coin_market_chart.dart';
import 'package:crypto_trends/features/coinInfo/domain/usescases/get_coin_market_chart.dart';
import 'package:crypto_trends/features/coinInfo/presenter/bloc/coininfo_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../testData/coin_market_chart.dart';
import 'coininfo_bloc_test.mocks.dart';

@GenerateMocks([GetCoinMarketChart])
void main() {
  late CoinInfoBloc coinInfoBloc;
  late MockGetCoinMarketChart usecase;

  setUp(() {
    usecase = MockGetCoinMarketChart();
    coinInfoBloc = CoinInfoBloc(usecase: usecase);
  });
  String tId = "bitcoin";
  String tCurrency = "usd";
  String tDays = "7";
  bool tDailyInterval = true;
  final CoinMarketChart coinMarketChart = CoinMarketChart(prices: testCoinMarketChart);

  test("initial should be [CoinInfoInitial]", () {
    expect(coinInfoBloc.state, CoinInfoInitial());
  });

  blocTest<CoinInfoBloc, CoinInfoState>("Should call usecase with corrent parameters", 
    build: () => coinInfoBloc,
  );

  // blocTest<CoinInfoBloc, CoinInfoState>(
  //   """ Should emit [CoinInfoLoading, CoinInfoLoaded] when GetCoinInfo is triggered
  //     and CoinMarketChart return 
  //   """,
  //   build: () => coinInfoBloc,
  //   act: (bloc) => bloc.add(GetCoinInfo(
  //     currency: tCurrency,
  //     id: tId,
  //     days: tDays,
  //     dailyInterval: tDailyInterval,
  //   )),
  //   expect: () => [CoinInfoLoading(), CoinInfoLoaded(coinMarketChart: coinMarketChart)]
  // );
}
