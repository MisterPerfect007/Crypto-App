
import 'package:flutter/material.dart';

class CustomInfos extends StatelessWidget {
  const CustomInfos({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          const TextSpan(text: "This is the first ", children: [
            TextSpan(
                text: "version 1.0.0 \n",
                style: TextStyle(fontWeight: FontWeight.w700)),
            TextSpan(text: "We still "),
            TextSpan(
                text: "building 🏗️ the app,",
                style: TextStyle(fontWeight: FontWeight.w700)),
            TextSpan(text: " adding more feature for you.\n\n"),
            TextSpan(text: "Coming features:\n"),
            TextSpan(
                text: "\t\t\t\t - Wishlist ⭐\n",
                style: TextStyle(fontWeight: FontWeight.w700)),
            TextSpan(
                text:
                    "\t\t\t\t - Notifications (price alert, big change, ...)\n",
                style: TextStyle(fontWeight: FontWeight.w700)),
            TextSpan(
                text: "\t\t\t\t - Change App langage\n",
                style: TextStyle(fontWeight: FontWeight.w700)),
            TextSpan(
                text: "\t\t\t\t - News 📰\n",
                style: TextStyle(fontWeight: FontWeight.w700)),
            TextSpan(
                text: "\t\t\t\t - and more ...\n",
                style: TextStyle(fontWeight: FontWeight.w700)),
          ]),
          style: TextStyle(
              fontFamily: 'Inter',
              color: theme.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 14),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              const TextSpan(
                  text: "All Data provided by ",
                  children: [
                    TextSpan(
                        text: "CoinGecko \n",
                        style:
                            TextStyle(fontWeight: FontWeight.w900)),
                  ]),
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontStyle: FontStyle.italic),
            ),
            Image.asset(
              "assets/logos/coingecko_logo.png",
              width: 30,
            )
          ],
        ),
      ],
    );
  }
}
