
import 'package:flutter/material.dart';

import '../../../ui/colors/colors.dart';
import '../../../ui/icons/svg_icons.dart';
import '../animation/custom_opacity_animation.dart';

class CustomErrorWidget extends StatelessWidget {
  final Function()? onPressed;
  final String msg;
  final SvgIcons icon;
  final double iconSize;
  const CustomErrorWidget({
    Key? key,
    this.onPressed,
    required this.msg,
    required this.icon, this.iconSize = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomOpacityAnimation(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcon(icon: icon, size: iconSize,),
              const SizedBox(height: 5),
              Text(msg),
              TextButton(
                  onPressed: onPressed,
                  child: const Text("Try again"),
                  style: TextButton.styleFrom(primary: AppColors.mainGreen)),
            ],
          ),
        ),
      ),
    );
  }
}
