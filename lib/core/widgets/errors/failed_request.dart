import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/widgets/animation/custom_opacity_animation.dart';
import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';

class FailedRequest extends StatelessWidget {
  final PersoIcons icon;
  final String title;
  final String secondTitle;
  final Function() buttonOnPressed;
  final String buttonText;
  final bool small;
  const FailedRequest({
    Key? key,
    required this.icon,
    required this.title,
    required this.secondTitle,
    required this.buttonOnPressed,
    required this.buttonText,
    this.small = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return CustomOpacityAnimation(
      child: Container(
        padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PersoIcon(
              icon: icon,
              color: null,
              size: small ? 50 : 150,
            ),
            SizedBox(
              height: small ? 10 : 20,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: small ? 12 : 25,
                color: const Color.fromARGB(255, 46, 46, 46),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: small ? 5 : 10,
            ),
            Text(
              secondTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: small? 10 : 20,
                color: AppColors.mainGrey,
              ),
            ),
            SizedBox(
              height: small? 10 : 40,
            ),
            ElevatedButton(
              onPressed: buttonOnPressed,
              child: Text(
                buttonText,
                style: GoogleFonts.inter(
                  fontSize: small? 12 : 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: small? const Size(50, 30) : const Size(150, 45),
              ),
            )
          ],
        )),
      ),
    );
  }
}
