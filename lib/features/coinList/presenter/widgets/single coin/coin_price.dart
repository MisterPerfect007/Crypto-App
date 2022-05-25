
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/icons/icons.dart';

class CoinPrice extends StatelessWidget {
  const CoinPrice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    fontSize: 11),
              ),
            )
          ],
        )
      ],
    );
  }
}
