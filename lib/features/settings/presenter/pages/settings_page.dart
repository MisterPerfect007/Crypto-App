import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets/currencyDropdown/currency_dropdown.dart';
import '../widgets/custom_infos.dart';
import '../widgets/theme_toggle.dart';

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
                        'Currency 💱',
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
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
                Text(
                  "Enjoy the App, Enjoy life 😋",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                const SizedBox(height: 25),
                CustomInfos(theme: theme),
                const SizedBox(height: 70)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
