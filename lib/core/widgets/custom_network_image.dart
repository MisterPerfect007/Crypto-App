import 'package:flutter/material.dart';

import 'coin_image_shimmer.dart';
import 'default_coin_image.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.image,
    required this.name, this.width = 40,
    
  }) : super(key: key);

  final String? image;
  final String name;
  final double width;

  @override
  Widget build(BuildContext context) {
    return image != null? FadeInImage.assetNetwork(
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
        }) : DefaultCoinImage(name: name, width: width);
  }
}