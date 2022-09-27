import 'package:crypto_trends/features/settings/utils/currencies.dart';
import 'package:flutter/material.dart';

import '../../../../ui/colors/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width / 25;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          50,
        ),
        child: const AppBar(),
      ),
      body: SafeArea(
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
                    const Text(
                      'Currency',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          menuMaxHeight: 300,
                          alignment: AlignmentDirectional.center,
                          value: "USD",
                          items: currenciesList
                              .map((currency) => DropdownMenuItem<String>(
                                    child: Row(),
                                  ))
                              .toList(),
                          onChanged: (index) {
                            // context.read<PaginationCubit>().changePage(index!);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // const SizedBox(height: 1500)
            ],
          ),
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width / 25;
    return SafeArea(
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
              left: sidePadding, right: sidePadding, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: AppColors.mainGrey.withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 0.5,
                  spreadRadius: 0),
            ],
          ),
          child: const Text(
            "Settings",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.pureBlack,
            ),
          )),
    );
  }
}
