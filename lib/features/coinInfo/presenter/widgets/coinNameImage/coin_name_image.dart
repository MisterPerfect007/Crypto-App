import 'package:crypto_trends/core/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';
import '../custom_ink_well_icon.dart';

class CoinNameImage extends StatelessWidget {
  const CoinNameImage({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);
  final String name;
  final String? image;

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
          Expanded(
            child: Row(
              children: [
                CustomNetworkImage(
                  image: image,
                  name: name,
                ),
                const SizedBox(
                  width: 10,
                ),
                //Name
                Flexible(
                  child: Text(
                    name,
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.mainBlack),
                  ),
                ),
              ],
            ),
          ),
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
