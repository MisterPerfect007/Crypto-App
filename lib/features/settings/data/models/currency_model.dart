import 'package:equatable/equatable.dart';

class CurrencyModel extends Equatable {
  final String fullName;
  final String shortName;
  final String symbol;
  final String image;

  const CurrencyModel({
    required this.fullName,
    required this.shortName,
    required this.symbol,
    required this.image,
  });

  factory CurrencyModel.fromJson(Map<String, String> json) {
    return CurrencyModel(
      fullName: json["fullName"].toString(),
      shortName: json["shortName"].toString(),
      symbol: json["symbol"].toString(),
      image: json["image"].toString(),
    );
  }
  
  Map<String, String> json(){
    return {
      "fullName": fullName,
      "shortName": shortName,
      "symbol": symbol,
      "image": image,
    };
  }

  @override
  List<Object?> get props => [fullName, shortName, symbol, image];
}

