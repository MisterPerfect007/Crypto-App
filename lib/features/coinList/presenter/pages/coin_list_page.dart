import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';

class CoinListPage extends StatelessWidget {
  const CoinListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          100,
        ),
        child: CoinPageAppBar(size: size),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: sidePadding,
          right: sidePadding,
        ),
        child: SingleChildScrollView(
          child: Row(
            children: [
              InkWell(
                splashColor: Color.fromARGB(255, 255, 4, 4),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 7,
                    bottom: 7,
                  ),
                  decoration: const BoxDecoration(
                      // color: AppColors.mainWhite,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        // BoxShadow(
                        //   color: AppColors.secondGrey,
                        //   spreadRadius: 2,
                        //   blurRadius: 10,
                        // ),
                      ]),
                  child: Text(
                    'Rank',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
