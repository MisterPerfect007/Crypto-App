import 'package:crypto_trends/features/loginAndRegister/presenter/widgets/login/login_form.dart';
import 'package:crypto_trends/services/firebase/auth/utils.dart';
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormHeader(title: 'Log in'),
                const SizedBox(height: 15),
                //Login
                // const LoginForm(),
                const SizedBox(height: 20),
                const OrSeparator(),
                const SizedBox(height: 20),
                SocialMediaField(
                  logo: SvgPicture.asset(
                    "assets/social_media_logos/facebook.svg",
                    width: 20,
                  ),
                  text: 'Continue with Facebook',
                  onPressed: () async {
                    await facebookLoginAndRegister();
                  },
                ),
                const SizedBox(height: 15),
                SocialMediaField(
                  logo: SvgPicture.asset(
                    "assets/social_media_logos/google.svg",
                    width: 20,
                  ),
                  text: 'Continue with Google',
                  onPressed: () async {
                    await googleLoginAndRegister();
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
