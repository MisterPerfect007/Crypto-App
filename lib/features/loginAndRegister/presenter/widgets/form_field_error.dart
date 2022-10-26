import 'package:flutter/material.dart';

class FormFieldError extends StatelessWidget {
  final String msg;
  const FormFieldError({

    Key? key, required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Text("*$msg",
            style: const TextStyle(
                color: Colors.red, fontFamily: 'Inter', fontSize: 12)),
      ],
    );
  }
}
