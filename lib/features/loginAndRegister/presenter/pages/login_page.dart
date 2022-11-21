import 'package:crypto_trends/services/firebase/auth/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/utils.dart';
import '../widgets/app_bar.dart';
import '../widgets/formFields/social_media_field.dart';
import '../widgets/formWidgets/form_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isProceeding = false;
  //

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
                text: 'Google',
                onPressed: !isProceeding
                    ? () async {
                      setState(() {
                          isProceeding = true;
                        });
                        await handleSignIn(context,
                            signInMethod: googleLoginAndRegister);
                        setState(() {
                          isProceeding = false;
                        });
                      }
                    : () {},
              ),
              // const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
