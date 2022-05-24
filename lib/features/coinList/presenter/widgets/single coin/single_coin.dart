
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import '../../pages/coin_list_page.dart';

class SingleCoin extends StatelessWidget {
  const SingleCoin({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
      padding: EdgeInsets.only(left: sidePadding, right: sidePadding, bottom: 10),
      margin: const EdgeInsets.only(top: 10,),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.secondGrey,))
      ),
      child: Row(
        children: [
          Image.network(
            'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
            width: 40,
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bitcoin',
                style: TextStyle(
                    color: AppColors.pureBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              const SizedBox(height: 3,),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 0,
                      right: 3,
                      bottom: 0,
                      left: 3,
                    ),
                    decoration: const BoxDecoration(
                        color: AppColors.thirdGrey,
                        borderRadius:
                            BorderRadius.all(Radius.circular(3))),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        color: AppColors.grey1,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'BTC',
                    style: TextStyle(
                      color: AppColors.grey1,
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  )
                ],
              )
            ],
          ),
          //Price
          //
          Expanded(
            child: Align(
              child: Container(
                height: 40,
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
                child: const SingleCoinLineChart(),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$ 32,021.59',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      color: AppColors.mainBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: 13),
                ),
              ),
              const SizedBox(height: 2,),
              Row(
                children: [
                  const PersoIcon(
                    icon: PersoIcons.arrowUp,
                    size: 9,
                    color: AppColors.mainGreen,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '+12.71%',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: AppColors.mainGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 10),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          //Favorite
          //
          InkWell(
            onTap: (){},
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const PersoIcon(
                icon: PersoIcons.starOutline,
                color: AppColors.mainGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
