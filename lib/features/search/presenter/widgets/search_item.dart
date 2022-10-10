import 'package:crypto_trends/features/coinInfo/presenter/page/coin_info.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_network_image.dart';
import '../../../../ui/colors/colors.dart';

class SearchItem extends StatelessWidget {
  final String id;
  final String? image;
  final String name;
  final String symbol;
  final int? rank;

  const SearchItem({
    Key? key,
    this.image,
    required this.name,
    required this.symbol,
    this.rank, required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);

    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CoinInfoPage(coin: null, id: id,)));
        },
        splashColor: AppColors.secondGrey,
        child: Padding(
          padding: EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: sidePadding,
            right: sidePadding,
          ),
          child: Row(
            children: [
              CustomNetworkImage(
                image: image,
                name: name,
                width: 40,
              ),
              const SizedBox(width: 10),
              //!name
              Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor
                  ),
                ),
              ),
              const SizedBox(width: 5),
              //!symbol
              Container(
                constraints: const BoxConstraints(maxWidth: 50),
                child: Text(
                  symbol.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainGrey),
                ),
              ),
              Expanded(child: Container()),
              //!rank
              Text(
                "#" + (rank?.toString() ?? "?"),
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
