import 'package:equatable/equatable.dart';

class Coin extends Equatable{
  final String id;
  final String symbol;
  final String name;
  final String? image;
  final double? currentPrice;
  final double? marketCap;
  final int? marketCapRank;
  final double? fullyDilutedValuation;
  final double? totalVolume;
  final double? high24h;
  final double? low24h;
  final double? priceChange24h;
  final double? priceChangePercentage24h;
  final double? marketCapChange24h;
  final double? marketCapChangePercentage24h;
  final double? circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final double? ath;
  final double? athChangePercentage;
  final String? athDate;
  final double? atl;
  final double? atlChangePercentage;
  final String? atlDate;
  final String? lastUpdated;
  final Map<String, dynamic>? sparklineIn7d;
  final double? priceChangePercentage7dInCurrency;

  const Coin({
    required this.id, 
    required this.symbol, 
    required this.name, 
    this.image, 
    this.currentPrice, 
    this.marketCap, 
    this.marketCapRank, 
    this.fullyDilutedValuation, 
    this.totalVolume, 
    this.high24h, 
    this.low24h, 
    this.priceChange24h, 
    this.priceChangePercentage24h, 
    this.marketCapChange24h, 
    this.marketCapChangePercentage24h, 
    this.circulatingSupply, 
    this.totalSupply, 
    this.maxSupply, 
    this.ath, 
    this.athChangePercentage, 
    this.athDate, 
    this.atl, 
    this.atlChangePercentage, 
    this.atlDate, 
    this.lastUpdated,
    this.sparklineIn7d,
    this.priceChangePercentage7dInCurrency
  }
  );

  @override
  List<Object?> get props => [id, symbol, name, image, currentPrice, marketCap, marketCapRank, fullyDilutedValuation, totalVolume, high24h, low24h, priceChange24h, priceChangePercentage24h, marketCapChange24h, marketCapChangePercentage24h, circulatingSupply, totalSupply, maxSupply, ath, athChangePercentage, athDate, atl, atlChangePercentage, atlDate, lastUpdated];
}