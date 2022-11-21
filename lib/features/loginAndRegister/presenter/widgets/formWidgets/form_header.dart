
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String title;
  const FormHeader({
    Key? key, required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            "assets/app/logos/logo.png",
            height: 90,
          ),
        ),
        const SizedBox(height: 40,), 
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
