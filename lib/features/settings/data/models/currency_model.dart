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

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      fullName: json["fullName"],
      shortName: json["shortName"],
      symbol: json["symbol"],
      image: json["image"],
    );
  }
  
  Map<String, dynamic> json(){
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

