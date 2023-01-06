import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static defaultToast(BuildContext context, String message) {
    final theme = Theme.of(context);
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: theme.primaryColor,
        textColor: theme.scaffoldBackgroundColor);
  }
}
