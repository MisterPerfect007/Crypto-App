import 'package:flutter/material.dart';

import '../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../ui/colors/colors.dart';
import '../widgets/see_all_page_app_bar.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({
    Key? key,
    required this.appBarTitle,
    required this.body,
  }) : super(key: key);
  final String appBarTitle;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            size.width,
            50,
          ),
          child: CustomOpacityAnimation(
              child: SeeAllPageAppBar(
            title: appBarTitle,
          )),
        ),
        body: Container(
          height: size.height,
          color: AppColors.lightBg,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  body,
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }
}
