import 'package:crypto_trends/features/coinInfo/presenter/widgets/custom_inkWell_icon.dart';
import 'package:crypto_trends/ui/icons/icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../ui/colors/colors.dart';
import '../widgets/coin_info_appBar.dart';
import '../widgets/custom_inkWell_icon.dart';

class CoinInfoPage extends StatelessWidget {
  const CoinInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          50,
        ),
        child: const CoinInfoPageAppBar(),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: sidePadding, right: sidePadding,),
        child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: [
                    //image
                    Image.network(
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
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: AppColors.mainBlack),
                    ),
                  ],
                ),
                // Expanded(child: Container()),
                CustomInkWellIcon(
                  onTap: () {},
                  child: const PersoIcon(
                    icon: PersoIcons.starOutline,
                    size: 25,
                    color: AppColors.mainGrey,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
