import 'package:crypto_trends/features/coinInfo/data/models/coin_market_chart_model.dart';
import 'package:crypto_trends/features/coinList/presenter/widgets/single%20coin/single_coin_line_chart.dart';
import 'package:equatable/equatable.dart';

class CoinMarketChart extends Equatable {
  final List<SingleDayCoinMarketChart> prices;

  const CoinMarketChart({required this.prices});

  @override
  List<Object?> get props => [prices];
  
}