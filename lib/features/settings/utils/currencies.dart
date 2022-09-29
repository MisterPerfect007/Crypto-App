import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final String fullName;
  final String shortName;
  final String symbol;
  final String image;

  const Currency({
    required this.fullName,
    required this.shortName,
    required this.symbol,
    required this.image,
  });

  @override
  List<Object?> get props => [fullName, shortName, symbol, image];
}

const currenciesList = [
  Currency(
    fullName: "US Dollar",
    shortName: "USD",
    symbol: "\$",
    image: "assets/icons/currencies-icons/icons8-us-dollar-circled-90.png",
  ),
  Currency(
    fullName: "Euro",
    shortName: "EUR",
    symbol: "€",
    image: "assets/icons/currencies-icons/icons8-euro-90.png",
  ),
  Currency(
    fullName: "Pound Sterling",
    shortName: "GBP",
    symbol: "£",
    image: "assets/icons/currencies-icons/icons8-british-pound-96.png",
  ),
  Currency(
    fullName: "Australian Dollar",
    shortName: "AUD",
    symbol: "\$",
    image: "assets/icons/countries-flag/australia.png",
  ),
  Currency(
    fullName: "Brazilian Real",
    shortName: "BRL",
    symbol: "R\$",
    image: "assets/icons/countries-flag/brazil.png",
  ),
  Currency(
    fullName: "Canadian Dollar",
    shortName: "CAD",
    symbol: "\$",
    image: "assets/icons/countries-flag/canada.png",
  ),
  Currency(
    fullName: "Swiss Franc",
    shortName: "CHF",
    symbol: "Fr",
    image: "assets/icons/countries-flag/switzerland.png",
  ),
  Currency(
    fullName: "Chilean Peso",
    shortName: "CLP",
    symbol: "\$",
    image: "assets/icons/countries-flag/chile.png",
  ),
  Currency(
    fullName: "Chinese Yuan",
    shortName: "CNY",
    symbol: "¥",
    image: "assets/icons/countries-flag/china.png",
  ),
  Currency(
    fullName: "Czech Koruna",
    shortName: "CZK",
    symbol: "Kč",
    image: "assets/icons/countries-flag/czech-republic.png",
  ),
  /* 
  Danish Krone
  DKK
  KR
   */

  /* 
  Hong Kong Dollar
  HKD
  \$
   */

  /* 
  Hungarian Forint
  HUF
  Ft
   */

  /* 
  Indonesian Rupiah
  IDR
  Rp
   */

  /* 
  Israeli New Shekel
  ILS
  ₪
   */
];


