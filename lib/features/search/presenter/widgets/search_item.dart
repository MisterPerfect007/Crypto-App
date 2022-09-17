import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_network_image.dart';
import '../../../../ui/colors/colors.dart';

class SearchItem extends StatelessWidget {
  final String? image;
  final String name;
  final String symbol;
  final int? rank;

  const SearchItem({
    Key? key,
    this.image,
    required this.name,
    required this.symbol,
    this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;

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
              CustomNetworkImage(
                image: image,
                name: name,
                width: 40,
              ),
              const SizedBox(width: 10),
              //!name
              Container(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              //!id
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
