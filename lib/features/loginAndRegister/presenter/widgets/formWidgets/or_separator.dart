
import 'package:flutter/material.dart';

class OrSeparator extends StatelessWidget {
  const OrSeparator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    return Row(
      children: [
        separator(theme),
        const SizedBox(
          width: 10,
        ),
        Text(
          "OR",
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: theme.primaryColor.withOpacity(0.8)),
        ),
        const SizedBox(
          width: 10,
        ),
        separator(theme)
      ],
    );
  }

  Expanded separator(ThemeData theme) {
    return Expanded(
      child: Container(
        color: theme.primaryColor.withOpacity(0.3),
        height: 1,
      ),
    );
  }
}
