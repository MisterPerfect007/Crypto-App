import 'package:crypto_trends/core/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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
    //
    final theme = Theme.of(context);
    //
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
                  width: 50,
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
                        color: theme.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
