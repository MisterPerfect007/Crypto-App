import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String) onChanged;
  final bool isValid;
  const CustomTextFormField({
    Key? key,
    required this.onChanged, required this.isValid,
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
              border: Border.all(color: (isValid? theme.primaryColor : theme.errorColor).withOpacity(0.2))),
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
              ),
              onChanged: onChanged,
              ),
              
        )
      ],
    );
  }
}
