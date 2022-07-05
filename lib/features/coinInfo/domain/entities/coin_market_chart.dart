import 'package:crypto_trends/features/coinInfo/data/models/coin_market_chart_model.dart';
import 'package:equatable/equatable.dart';

class CoinMarketChart extends Equatable {
  final List<SingleCoinMarketChartData> prices;

  const CoinMarketChart({required this.prices});

  @override
  List<Object?> get props => [prices];
  
}