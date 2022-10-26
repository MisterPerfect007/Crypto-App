import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../formFields/custom_password_form_field.dart';
import '../formFields/custom_text_form_field.dart';
import '../form_field_error.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
          //email
          CustomTextFormField(
            onChanged: setEmailValue,
            isValid: isEmailValid,
          ),
          //email if is not valide
          if (!isEmailValid) const FormFieldError(msg: 'Email not correct'),
          const SizedBox(height: 15),
          //password
          CustomPasswordFormField(
            onChanged: setPwdValue,
            isValid: isPwdValid,
          ),
          if (!isPwdValid) const FormFieldError(msg: 'Password is too short, should be at least 8 characters'),
          const SizedBox(height: 15),
          //!
          //
          ElevatedButton(
            onPressed: validate,
            child: const Text("Continue with Email and Password"),
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void validate() {
    setState(() {
      isEmailValid = EmailValidator.validate(emailValue) ? true : false;
      isPwdValid = pwdValue.length >= 8 ? true : false;
    });

  }
}
