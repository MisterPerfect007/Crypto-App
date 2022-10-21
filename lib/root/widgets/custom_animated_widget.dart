import 'package:flutter/material.dart';

class CustomAnimatedWidget extends AnimatedWidget {
  const CustomAnimatedWidget(
      {key, required this.animation, required this.child})
      : super(
          key: key,
          listenable: animation,
        );

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: child,
    );
  }
}
