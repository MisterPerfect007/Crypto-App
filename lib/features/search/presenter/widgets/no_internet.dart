
import 'package:flutter/material.dart';

import '../../../../ui/colors/colors.dart';

class NoInternet extends StatefulWidget {
  final Widget? icon;
  final String? text;
  final double? height;
  final Duration? duration;
  const NoInternet({
    Key? key,
    this.icon,
    this.text,
    this.height,
    this.duration,
  }) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  double _height = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _height = widget.height ?? 40;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: widget.duration ?? const Duration(milliseconds: 500),
        height: _height,
        color: AppColors.secondGrey.withOpacity(0.3),
        child: Center(
          child: SingleChildScrollView(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              widget.icon ?? Container(),
              const SizedBox(width: 10),
              Text(
                widget.text ?? "",
                style: const TextStyle(fontFamily: 'Inter'),
              )
            ]),
          ),
        ));
  }
}
