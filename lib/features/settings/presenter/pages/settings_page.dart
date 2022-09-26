import 'package:flutter/material.dart';

import '../../../../ui/colors/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width / 25;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: sidePadding, right: sidePadding, top: 10),
                  child: const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.pureBlack,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
