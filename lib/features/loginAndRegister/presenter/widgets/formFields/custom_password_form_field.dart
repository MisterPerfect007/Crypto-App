import 'package:flutter/material.dart';

import '../../../../../ui/icons/svg_icons.dart';

class CustomPasswordFormField extends StatefulWidget {
  final void Function(String) onChanged;
  final bool isValid;
  const CustomPasswordFormField({
    Key? key, required this.onChanged, required this.isValid,
  }) : super(key: key);

  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool isPasswordVisible = true;

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
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          width: size.width,
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
              border: Border.all(color: (widget.isValid? theme.primaryColor : theme.errorColor).withOpacity(0.2))),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                    obscureText: isPasswordVisible,
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
                    ),
                    onChanged: widget.onChanged,
                    ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                child: SvgIcon(
                  icon: isPasswordVisible
                      ? SvgIcons.eyeOpen
                      : SvgIcons.eyeSlashed,
                  color: theme.primaryColor.withOpacity(0.8),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
