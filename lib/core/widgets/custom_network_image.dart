import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'coin_image_shimmer.dart';
import 'default_coin_image.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.image,
    required this.name,
    this.width = 40,
  }) : super(key: key);

  final String? image;
  final String name;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return /* FadeInImage.assetNetwork(
        fadeInDuration: const Duration(milliseconds: 100),
        placeholder: '',
        placeholderErrorBuilder:
            (BuildContext context, Object object, StackTrace? stackTrace) {
          return CoinImageShimmer(width: width,);
        },
        image: image!,
        width: width,
        fit: BoxFit.fitWidth,
        imageErrorBuilder: (context, error, stackTrace) {
          return DefaultCoinImage(name: name, width: width);
        }) */
          CachedNetworkImage(
        width: width,
        imageUrl: image!,
        placeholder: (context, url) => CoinImageShimmer(width: width),
        errorWidget: (context, url, error) =>
            DefaultCoinImage(name: name, width: width),
        fadeOutDuration: const Duration(milliseconds: 300),
        fadeInDuration: const Duration(milliseconds: 300),
      );
    } else {
      return DefaultCoinImage(name: name, width: width);
    }
  }
}
