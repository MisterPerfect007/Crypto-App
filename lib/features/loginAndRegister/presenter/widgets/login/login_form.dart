import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../formFields/custom_password_form_field.dart';
import '../formFields/custom_text_form_field.dart';
import '../form_field_error.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //Email
  bool isEmailValid = true;
  String emailValue = "";
  void setEmailValue(value) {
    emailValue = value;
  }

  //Password
  bool isPwdValid = true;
  String pwdValue = "";
  void setPwdValue(value) {
    pwdValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          //Email field
          CustomTextFormField(onChanged: setEmailValue, isValid: isEmailValid),
          if (!isEmailValid) const FormFieldError(msg: 'Email not correct'),
          const SizedBox(height: 15),
          //
          //Password field
          CustomPasswordFormField(onChanged: setPwdValue, isValid: isPwdValid),
          if (!isPwdValid)
            const FormFieldError(
                msg: 'Password is too short, should be at least 8 characters'),
          TextButton(onPressed: () {}, child: const Text("Forgot Password ?")),
          ElevatedButton(
            onPressed: validate,
            child: const Text("Login"),
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void validate() {
    // di.sl<FireAuth>().signInWithEmailAndPassword(emailValue.trim(), pwdValue.trim());
    setState(() {
      isEmailValid = EmailValidator.validate(emailValue) ? true : false;
      isPwdValid = pwdValue.length >= 8 ? true : false;
    });
    
  }
}
