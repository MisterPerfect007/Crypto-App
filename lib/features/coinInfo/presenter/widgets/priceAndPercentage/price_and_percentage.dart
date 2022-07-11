import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/coinPercentage/coin_percentage_format.dart';
import '../../../../../ui/icons/icons.dart';

// ignore: must_be_immutable
class PriceAndPercentage extends StatelessWidget {
  final double? percentage;
  late CoinPercentageFormat formatedPercentage;
  PriceAndPercentage({Key? key, required this.percentage}) : super(key: key) {
    formatedPercentage = CoinPercentageFormat(percentage: percentage);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              //! should handle lenght constraint
              Expanded(
                child: Text(
                  "\$40,803.900,000,000,000",
                  style: GoogleFonts.inter(
                      fontSize: 24, fontWeight: FontWeight.w800),
                  // overflow: TextOverflow.fade,
                ),
              ),
              // Expanded(child: Container()),
              const SizedBox(width: 10,),
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: formatedPercentage.getColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Row(children: [
                    PersoIcon(
                      icon: PersoIcons.arrowUp,
                      size: 10,
                      color: formatedPercentage.getColor,
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      formatedPercentage.fixedPercentage() + "%",
                      style: GoogleFonts.inter(
                        color: formatedPercentage.getColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ]))
            ],
          ),
          const SizedBox(height: 5,),
          Text(
            '+\$ 320.90',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: formatedPercentage.getColor
            ),
          )
        ],
      ),
    );
  }
}
