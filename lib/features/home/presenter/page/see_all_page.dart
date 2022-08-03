import 'package:flutter/material.dart';

import '../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../ui/colors/colors.dart';
import '../../../coinInfo/presenter/widgets/coin_info_app_bar.dart';
import '../widgets/see_all_page_app_bar.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({Key? key, required this.appBarTitle, required this.body,}) : super(key: key);
  final String appBarTitle;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          60,
        ),
        child: CustomOpacityAnimation(child: SeeAllPageAppBar(title: appBarTitle,)),
      ),
      body: CustomOpacityAnimation(
            child: Container(
              height: size.height,
              padding: const EdgeInsets.only(top: 20),
              color: AppColors.lightBg,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: body,
                  ),
                ),
              ),
            ),
          )
    );
  }
}
