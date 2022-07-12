import 'package:flutter/material.dart';

class CustomOpacityAnimation extends StatefulWidget {
  const CustomOpacityAnimation({ Key? key, required this.child }) : super(key: key);
  final Widget child;

  @override
  State<CustomOpacityAnimation> createState() => _CustomOpacityAnimationState();
}

class _CustomOpacityAnimationState extends State<CustomOpacityAnimation> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _opacity = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity, 
      duration: const Duration(milliseconds: 500),
      child: widget.child,
      );
  }
}