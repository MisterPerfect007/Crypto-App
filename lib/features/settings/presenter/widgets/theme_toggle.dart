
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/cubit/app_theme_cubit.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  @override
  Widget build(BuildContext context) {
    //
    bool isOn = widget.theme.brightness == Brightness.dark;
    //
    return BlocBuilder<AppThemeCubit, ThemeData>(
      builder: (context, state) {
        return Row(
          children: [
            Text(
              'Dark theme',
              style: TextStyle(
                fontFamily: 'Inter',
                color: widget.theme.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(child: Container()),
            Switch.adaptive(
                value: isOn,
                onChanged: (_) {
                  setState(() {
                    isOn = !isOn;
                  });
                  context.read<AppThemeCubit>().switchTheme();
                })
          ],
        );
      },
    );
  }
}
