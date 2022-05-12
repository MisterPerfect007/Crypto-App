import 'package:crypto_trends/features/coinList/data/models/coin_model.dart';

abstract class CoinListRemoteDataSource{
  /// Make a call to the coin list API enpoint: https://api.coingecko.com/api/v3/coins/markets?{ some given arguments}
  /// 
  /// throw a [ServerException] when something went wrong
  Future<List<CoinModel>> getRemoteCoinList({required currency, int? page});
}