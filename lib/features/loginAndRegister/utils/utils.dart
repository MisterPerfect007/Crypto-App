import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> handleSignIn(BuildContext context,
    {required Future<Either<List<String>, UserCredential>> Function()
        signInMethod}) async {
  //
  final errorOrUserCredential = await signInMethod();
  //
  errorOrUserCredential.fold(
      //
      (error) {
    showCustomDialog(context,
        title: error[0],
        bodyText: error[1],
        onBtnTap: () {},
        type: CustomDialog.failed);
  },
      //
      (userCredential) {
    bool isNewUser = userCredential.additionalUserInfo!.isNewUser;

    String title =
        isNewUser ? "Account created successfuly" : "Signed In successfuly";
    String bodyText = isNewUser
        ? "Your account have been created successfuly, and you are signed in now.\nThanks to you."
        : "You are now signed in.\nThanks to you";
    showCustomDialog(context, title: title, bodyText: bodyText, onBtnTap: () {
      // Navigator.of(context).pop();
    }, type: CustomDialog.success);
  });
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
  //
  // final theme = Theme.of(context);
  return showDialog(
    barrierDismissible: false,
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
                color: AppColors.lightBg,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                const SizedBox(height: 20),
                Text(bodyText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
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
