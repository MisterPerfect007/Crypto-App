import 'package:crypto_trends/features/loginAndRegister/presenter/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/app_bar.dart';
import '../widgets/formFields/custom_password_form_field.dart';
import '../widgets/formFields/custom_text_form_field.dart';
import '../widgets/formFields/social_media_field.dart';
import '../widgets/formWidgets/form_header.dart';
import '../widgets/formWidgets/or_separator.dart';
import '../widgets/register/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //
    final double sidePadding = size.width / 25;
    //
    // final theme = Theme.of(context);
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
                const FormHeader(title: 'Create an account'),
                const SizedBox(height: 15),
                //!
                //Social media c
                SocialMediaField(
                  logo: SvgPicture.asset("assets/social_media_logos/google.svg",
                      width: 20),
                  text: 'Continue with Google',
                ),
                const SizedBox(height: 15),
                SocialMediaField(
                  logo: SvgPicture.asset(
                      "assets/social_media_logos/facebook.svg",
                      width: 20),
                  text: 'Continue with Facebook',
                ),
                const SizedBox(height: 20),
                const OrSeparator(),
                //!
                //email and password
                //!
                const SizedBox(height: 20),
                const RegisterForm(),
                //!
                //
                Row(
                  children: [
                    const Text(
                      'Already have an account,',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
