
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_network_image.dart';
import '../../../../ui/colors/colors.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;

    String name = "Bitcoin-vs";

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
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
              const CustomNetworkImage(
                image:
                    "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
                name: "name",
                width: 25,
              ),
              const SizedBox(width: 10),
              Container(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 50),
                child: const Text(
                  "BTC",
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainGrey),
                ),
              ),
              Expanded(child: Container()),
              const Text(
                "#1",
                style: TextStyle(
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
