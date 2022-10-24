import 'package:crypto_trends/ui/icons/svg_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/navigation/go_back_widget.dart';
import '../../../../ui/colors/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //
    final double sidePadding = size.width / 25;
    //
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          50,
        ),
        child: SafeArea(
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    color: AppColors.mainGrey.withOpacity(0.1),
                    offset: const Offset(0, 1),
                    blurRadius: 0.5,
                    spreadRadius: 0),
              ],
            ),
            child: Row(
              children: const [GoBack()],
            ),
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(left: sidePadding, right: sidePadding),

        // color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/app/logos/logo.png",
                  height: 100,
                ),
              ),
              const Text(
                "Log in",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(),
              const SizedBox(height: 15),
              CustomPasswordFormField(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.primaryColor.withOpacity(0.8)),
        ),
        const SizedBox(height: 5),
        Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              color: theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    color: theme.primaryColor.withOpacity(0.1),
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: const Offset(0, 0))
              ],
              border: Border.all(color: theme.primaryColor.withOpacity(0.2))),
          child: TextFormField(
              decoration: const InputDecoration(
                isCollapsed: true,
                hintText: "hello@company.com",
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
              )),
        )
      ],
    );
  }
}

class CustomPasswordFormField extends StatelessWidget {
  const CustomPasswordFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
    //
    final theme = Theme.of(context);
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.primaryColor.withOpacity(0.8)),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              color: theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                color: theme.primaryColor.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(0, 0)
              )
              ],
              border: Border.all(color: theme.primaryColor.withOpacity(0.2))),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      hintText: "Your password",
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                    )),
              ),
                InkWell(
                  onTap: (){},
                  child: SvgIcon(icon: SvgIcons.eyeOpen),
                )
            ],
          ),
        )
      ],
    );
  }
}
