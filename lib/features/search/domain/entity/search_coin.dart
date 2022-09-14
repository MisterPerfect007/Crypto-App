import 'package:equatable/equatable.dart';

class SearchCoin extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final String? image;
  final int? marketCapRank;

  const SearchCoin({
    required this.id,
    required this.name,
    required this.symbol,
    this.image,
    this.marketCapRank,
  });

  @override
  List<Object?> get props => [id, name, symbol, image, marketCapRank];
}
