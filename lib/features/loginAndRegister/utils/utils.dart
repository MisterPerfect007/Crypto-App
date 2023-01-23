import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/dialog/show_custom_dialog.dart';


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
        onSubmit: () {},
        type: CustomDialog.failed,
        submitText: 'OK');
  },
      //
      (userCredential) {
    bool isNewUser = userCredential.additionalUserInfo!.isNewUser;

    String title =
        isNewUser ? "Account created successfuly" : "Signed In successfuly";
    String bodyText = isNewUser
        ? "Your account have been created successfuly, and you are signed in now.\nThanks to you."
        : "You are now signed in.\nThanks to you";
    showCustomDialog(context, title: title, bodyText: bodyText, onSubmit: () {
      // Navigator.of(context).pop();
    }, type: CustomDialog.success, submitText: 'Finish !');
  });
}
