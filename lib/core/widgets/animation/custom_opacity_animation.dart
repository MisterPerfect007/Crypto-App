import 'package:flutter/material.dart';

class CustomOpacityAnimation extends StatefulWidget {
  const CustomOpacityAnimation({ Key? key, required this.child, this.duration = const Duration(milliseconds: 300)}) : super(key: key);
  final Widget child;
  final Duration duration;

  @override
  State<CustomOpacityAnimation> createState() => _CustomOpacityAnimationState();
}

class _CustomOpacityAnimationState extends State<CustomOpacityAnimation> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
      duration: widget.duration,
      child: widget.child,
      );
  }
}