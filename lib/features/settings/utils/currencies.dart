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
  Currency(
    fullName: "Danish Krone",
    shortName: "DKK",
    symbol: "KR",
    image: "assets/icons/countries-flag/denmark.png",
  ),
  Currency(
    fullName: "Hong Kong Dollar",
    shortName: "HKD",
    symbol: "\$",
    image: "assets/icons/countries-flag/hong-kong.png",
  ),
  Currency(
    fullName: "Hungarian Forint",
    shortName: "HUF",
    symbol: "Ft",
    image: "assets/icons/countries-flag/hungary.png",
  ),
  Currency(
    fullName: "Indonesian Rupiah",
    shortName: "IDR",
    symbol: "Rp",
    image: "assets/icons/countries-flag/indonesia.png",
  ),
  Currency(
    fullName: "Israeli New Shekel",
    shortName: "ILS",
    symbol: "₪",
    image: "assets/icons/countries-flag/israel.png",
  ),
  Currency(
    fullName: "Indian Rupee",
    shortName: "INR",
    symbol: "₹",
    image: "assets/icons/countries-flag/india.png",
  ),
  Currency(
    fullName: "Japanese Yen",
    shortName: "JPY",
    symbol: "¥",
    image: "assets/icons/countries-flag/japan.png",
  ),
  Currency(
    fullName: "South Korean Won",
    shortName: "KRW",
    symbol: "₩",
    image: "assets/icons/countries-flag/south-korea.png",
  ),
  Currency(
    fullName: "Mexican Peso",
    shortName: "MXN",
    symbol: "\$",
    image: "assets/icons/countries-flag/mexican-flag.png",
  ),
  Currency(
    fullName: "Malaysian Ringgit",
    shortName: "MYR",
    symbol: "RM",
    image: "assets/icons/countries-flag/malaysia.png",
  ),
  Currency(
    fullName: "Norwegian Krone",
    shortName: "NOK",
    symbol: "kr",
    image: "assets/icons/countries-flag/norway.png",
  ),
  Currency(
    fullName: "New Zealand Dollar",
    shortName: "NZD",
    symbol: "\$",
    image: "assets/icons/countries-flag/new-zeland.png",
  ),
  Currency(
    fullName: "Philippine Peso",
    shortName: "PHP",
    symbol: "₱",
    image: "assets/icons/countries-flag/philippines.png",
  ),
  Currency(
    fullName: "Pakistani Rupee",
    shortName: "PKR",
    symbol: "₨",
    image: "assets/icons/countries-flag/pakistan.png",
  ),
  Currency(
    fullName: "Polish Złoty",
    shortName: "PLN",
    symbol: "zł",
    image: "assets/icons/countries-flag/poland.png",
  ),
  Currency(
    fullName: "Russian Ruble",
    shortName: "RUB",
    symbol: "₽",
    image: "assets/icons/countries-flag/russia.png",
  ),
  Currency(
    fullName: "Swedish Krona",
    shortName: "SEK",
    symbol: "kr",
    image: "assets/icons/countries-flag/russia.png",
  ),
  Currency(
    fullName: "Singapore Dollar",
    shortName: "SGD",
    symbol: "S\$",
    image: "assets/icons/countries-flag/singapore.png",
  ),
  Currency(
    fullName: "Thai Baht",
    shortName: "THB",
    symbol: "฿",
    image: "assets/icons/countries-flag/thailand.png",
  ),
  Currency(
    fullName: "Turkish Lira",
    shortName: "TRY",
    symbol: "₺",
    image: "assets/icons/countries-flag/turkey.png",
  ),
  Currency(
    fullName: "New Taiwan Dollar",
    shortName: "TWD",
    symbol: "NT\$",
    image: "assets/icons/countries-flag/taiwan.png",
  ),
  Currency(
    fullName: "South African Rand",
    shortName: "ZAR",
    symbol: "R",
    image: "assets/icons/countries-flag/south-africa.png",
  ),
  Currency(
    fullName: "Vietnamese Dong",
    shortName: "VND",
    symbol: "₫",
    image: "assets/icons/countries-flag/vietnam.png",
  ),
  Currency(
    fullName: "Argentine Peso",
    shortName: "ARS",
    symbol: "ARS",
    image: "assets/icons/countries-flag/argentina.png",
  ),
  Currency(
    fullName: "Ukrainian Hryvnia",
    shortName: "UAH",
    symbol: "UAH",
    image: "assets/icons/countries-flag/ukraine.png",
  ),
  Currency(
    fullName: "Nigerian Naira",
    shortName: "NGN",
    symbol: "NGN",
    image: "assets/icons/countries-flag/nigeria.png",
  ),
  Currency(
    fullName: "U. A. E. Dirham",
    shortName: "AED",
    symbol: "AED",
    image: "assets/icons/countries-flag/united-arab-emirates.png",
  ),
  Currency(
    fullName: "Saudi Riyal",
    shortName: "SAR",
    symbol: "SAR",
    image: "assets/icons/countries-flag/saudi-arabia.png",
  ),
  Currency(
    fullName: "Bangladeshi Taka",
    shortName: "BDT",
    symbol: "BDT",
    image: "assets/icons/countries-flag/bangladesh.png",
  ),
];
