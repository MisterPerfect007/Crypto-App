import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/cubit/app_theme_cubit.dart';
import '../widgets/app_bar.dart';
import '../widgets/currencyDropdown/currency_dropdown.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width / 25;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          50,
        ),
        child: const SettingsAppBar(),
      ),
      body: SafeArea(
        child: Container(
          color: theme.scaffoldBackgroundColor,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      left: sidePadding, right: sidePadding, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Currency',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const CurrencyDropdown(),
                      const SizedBox(height: 25),
                      ThemeToggle(theme: theme),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                const SizedBox(height: 70)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
                fontWeight: FontWeight.w500,
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
