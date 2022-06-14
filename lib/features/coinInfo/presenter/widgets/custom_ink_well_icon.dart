import 'package:flutter/material.dart';

class CustomInkWellIcon extends StatelessWidget {
  const CustomInkWellIcon({
    Key? key,
    required this.onTap,
    required this.child,
    required this.size,
    required this.radius,
  }) : super(key: key);
  final Function() onTap;
  final Widget child;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: const Color.fromARGB(255, 199, 199, 199),
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        onTap: onTap,
        child: Container(
          height: size,
          width: size,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
