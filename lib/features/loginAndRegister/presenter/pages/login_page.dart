import 'package:crypto_trends/features/loginAndRegister/presenter/widgets/login/login_form.dart';
import 'package:crypto_trends/services/firebase/auth/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/app_bar.dart';
import '../widgets/formFields/social_media_field.dart';
import '../widgets/formWidgets/form_header.dart';
import '../widgets/formWidgets/or_separator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //
    final double sidePadding = size.width / 25;
    //
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          50,
        ),
        child: const CustomAppBar(),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        // color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const FormHeader(title: 'Create account or Login with'),
              // const SizedBox(height: 15),
              //Login
              // const LoginForm(),
              const SizedBox(height: 20),
              SocialMediaField(
                logo: SvgPicture.asset(
                  "assets/social_media_logos/facebook.svg",
                  width: 20,
                ),
                text: 'Facebook',
                onPressed: () async {
                  // await handleSignIn(context, signInMethod: facebookLoginAndRegister);
                  print(FirebaseAuth.instance.currentUser);
                  
                },
              ),
              const SizedBox(height: 15),
              SocialMediaField(
                logo: SvgPicture.asset(
                  "assets/social_media_logos/google.svg",
                  width: 20,
                ),
                text: 'Google',
                onPressed: () async {
                  await handleSignIn(context, signInMethod: googleLoginAndRegister);
                },
              ),
              // const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> handleSignIn(BuildContext context,
    {required Future<Either<List<String>, UserCredential>> Function()
        signInMethod}) async {
  //
  final errorOrUserCredential = await signInMethod();
  //
  errorOrUserCredential.fold((error) {
    showCustomDialog(context,
        title: error[0],
        bodyText: error[1],
        onBtnTap: () {},
        type: CustomDialog.failed);
  }, (userCredential) {});
}




Future showCustomDialog(
  BuildContext context, {
  required CustomDialog type,
  required String title,
  required String bodyText,
  required Function() onBtnTap,
}) async {
  double radius = 10;
  Color color;
  if (type == CustomDialog.success) {
    color = Colors.green;
  } else {
    color = type == CustomDialog.warning ? Colors.orange : Colors.red.shade400;
  }
  IconData icon;
  if (type == CustomDialog.success) {
    icon = Icons.verified;
  } else {
    icon = type == CustomDialog.warning ? Icons.warning : Icons.close;
  }
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                )),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                Text(bodyText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                    )),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      onBtnTap();
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            ),
          )
        ],
      ),
    ),
  );
}

enum CustomDialog { success, failed, warning }
