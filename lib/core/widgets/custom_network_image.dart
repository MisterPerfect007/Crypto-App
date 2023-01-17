import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'coin_image_shimmer.dart';
import 'default_coin_image.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.image,
    required this.name,
    this.width = 40, this.radius,
  }) : super(key: key);

  final String? image;
  final String name;
  final double width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    //
    if (image != null) {
      return Container(
        color: isDarkMode ? const Color.fromARGB(27, 245, 245, 245) : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius?? 0),
          child: CachedNetworkImage(
            width: width,
            imageUrl: image!,
            placeholder: (context, url) => CoinImageShimmer(width: width),
            errorWidget: (context, url, error) =>
                DefaultCoinImage(name: name, width: width),
            fadeOutDuration: const Duration(milliseconds: 300),
            fadeInDuration: const Duration(milliseconds: 300),
          ),
        ),
      );
    } else {
      return DefaultCoinImage(name: name, width: width);
    }
  }
}
