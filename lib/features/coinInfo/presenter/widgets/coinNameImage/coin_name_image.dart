
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import '../custom_ink_well_icon.dart';

class CoinNameImage extends StatelessWidget {
  const CoinNameImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(
        left: sidePadding,
        right: sidePadding,
      ),
      child: Row(
        children: [
          Row(
            children: [
              FadeInImage.assetNetwork(
                key: ValueKey(DateTime.now()),
                placeholder: 'assets/icons/arrow.png',
                image:
                    "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
                width: 50,
              ),
              const SizedBox(
                width: 10,
              ),
              //Name
              Text(
                'Bitcoin',
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainBlack),
              ),
            ],
          ),
          Expanded(child: Container()),
          CustomInkWellIcon(
            onTap: () {},
            size: 45,
            radius: 45,
            child: const PersoIcon(
              icon: PersoIcons.starOutline,
              size: 25,
              color: AppColors.mainGrey,
            ),
          )
        ],
      ),
    );
  }
}
