import 'package:flutter/material.dart';


class SocialMediaField extends StatelessWidget {
  final Widget logo;
  final String text;
  const SocialMediaField({
    Key? key, required this.logo, required this.text,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: theme.primaryColor.withOpacity(0.1),
                blurRadius: 0.5,
                spreadRadius: 0.5,
                offset: const Offset(0, 0))
          ],
          border:
              Border.all(color: theme.primaryColor.withOpacity(0.1))),
      height: 40,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            logo,
            Text(
              text,
              style: TextStyle(
                  color: theme.primaryColor.withOpacity(0.9)),
            ),
            Visibility(
                visible: false,
                child: logo),
          ],
        ),
      ),
    );
  }
}
