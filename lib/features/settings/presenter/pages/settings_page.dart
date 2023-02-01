import 'package:crypto_trends/core/widgets/appBar/custom_app_bar.dart';
import 'package:crypto_trends/core/widgets/toast/toast.dart';
import 'package:crypto_trends/features/loginAndRegister/presenter/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/dialog/show_custom_dialog.dart';
import '../../../../services/firebase/auth/utils.dart';
import '../widgets/currencyDropdown/currency_dropdown.dart';
import '../widgets/theme_toggle.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width / 25;
    //
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, 50),
        child: const CustomAppBar(title: "Settings 🗝️"),
      ),
      body: SafeArea(
        child: Container(
          color: theme.scaffoldBackgroundColor,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      left: sidePadding, right: sidePadding, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Currency 💱',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const CurrencyDropdown(),
                      const SizedBox(height: 25),
                      ThemeToggle(theme: theme),
                      const SizedBox(height: 25),
                      const LoginLogout()
                    ],
                  ),
                ),
                //
                const SizedBox(height: 80),
                //Coingecko
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text.rich(
                          const TextSpan(
                              text: "All Data provided by ",
                              children: [
                                TextSpan(
                                    text: "CoinGecko \n",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900)),
                              ]),
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Image.asset("assets/logos/coingecko_logo.png", width: 30)
                    ],
                  ),
                ),
                const PrivacyPolicy()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginLogout extends StatefulWidget {
  const LoginLogout({Key? key}) : super(key: key);

  @override
  State<LoginLogout> createState() => _LoginLogoutState();
}

class _LoginLogoutState extends State<LoginLogout> {
  User? user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen(
      (userr) {
        setState(() {
          user = userr;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        user == null
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text("Login or Register"),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomNetworkImage(
                          image: user?.photoURL,
                          name: user?.email ?? "",
                          width: 60,
                          radius: 60,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (user?.displayName ??
                              user?.email ?? ""),
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              // overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        showCustomDialog(
                          context,
                          title: 'Do you want to Logout ?',
                          bodyText: '',
                          onSubmit: () => logout(),
                          submitText: 'Yes',
                          onCancel: () {},
                          cancelText: 'No',
                          type: CustomDialog.warning,
                        );
                      },
                      child: const Text("Logout")),
                ],
              )
      ],
    );
  }
}

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async => await showPrivacyPolicy(context),
        child: const Text("Privacy policy"));
  }
}

Future showPrivacyPolicy(BuildContext context) async {
  Uri url = Uri(
      scheme: 'https',
      host: 'github.com',
      path:
          'MisterPerfect007/crypto-trends-privacy-policy/blob/main/privacy-policy.md');
  try {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (e) {
    CustomToast.defaultToast(context, "An unexpected error occurred");
  }
}
