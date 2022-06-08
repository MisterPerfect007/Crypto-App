import 'package:flutter/material.dart';


class CustomInkWellIcon extends StatelessWidget {
  const CustomInkWellIcon({Key? key, required this.onTap, required this.child})
      : super(key: key);
  final Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color.fromARGB(255, 199, 199, 199),
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: child,
      ),
    );
  }
}
