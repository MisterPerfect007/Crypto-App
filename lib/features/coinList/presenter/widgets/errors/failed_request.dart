import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../ui/colors/colors.dart';
import '../../../../../ui/icons/icons.dart';

class OfflineError extends StatefulWidget {
  final PersoIcons icon;
  final String title;
  final String secondTitle;
  final Function() buttonOnPressed;
  final String buttonText;
  const OfflineError({
    Key? key,
    required this.icon,
    required this.title,
    required this.secondTitle,
    required this.buttonOnPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<OfflineError> createState() => _OfflineErrorState();
}

class _OfflineErrorState extends State<OfflineError> {
  double _opacity = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _opacity = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sidePadding = size.width / 25;
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 700),
      child: Container(
        padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PersoIcon(
              icon: widget.icon,
              color: null,
              size: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 25,
                color: const Color.fromARGB(255, 46, 46, 46),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.secondTitle,
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.roboto(fontSize: 20, color: AppColors.mainGrey),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: widget.buttonOnPressed,
              child: Text(
                widget.buttonText,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: const Size(150, 45),
              ),
            )
          ],
        )),
      ),
    );
  }
}
