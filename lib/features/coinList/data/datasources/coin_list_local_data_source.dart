import 'package:crypto_trends/features/coinList/data/models/coin_model.dart';

abstract class CoinListLocalDataSource{
  /// Get cached data
  /// 
  /// throw a [CacheException] when something went wrong or no data present
  Future<List<CoinModel>> getLocalCoinList();
}