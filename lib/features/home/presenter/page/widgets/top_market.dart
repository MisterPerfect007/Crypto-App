
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Container(
      // height: 200,
      width: size.width,
      padding: EdgeInsets.only(
          left: sidePadding, right: sidePadding, top: 20, bottom: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            AppColors.mainGreen,
            Color.fromARGB(255, 0, 251, 121),
          ],
        ),
      ),
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to",
                style: GoogleFonts.inter(
                    color: AppColors.mainWhite.withOpacity(0.7),
                    fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Crypto Trend",
                style: GoogleFonts.inter(
                    color: AppColors.mainWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Market is Uptrend",
                    style: GoogleFonts.inter(
                        color: AppColors.mainWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  Expanded(child: Container()),
                  Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: AppColors.mainWhite.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                        ),
                    child: Row(children: [
                      const PersoIcon(
                        icon: PersoIcons.arrowUp,
                        size: 12,
                        color: AppColors.mainWhite,
                      ),
                      const SizedBox(width: 5),
                      Text("20.2%", style: GoogleFonts.inter(
                        color: AppColors.mainWhite,
                        fontWeight: FontWeight.w600
                      ),)
                    ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                "In the last 24h (Top-100)",
                style: GoogleFonts.inter(
                    color: AppColors.mainWhite.withOpacity(0.7),
                    fontSize: 12),
              ),
            ],
          )
        ],
      )),
    );
  }
}
