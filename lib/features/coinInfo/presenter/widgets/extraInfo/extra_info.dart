
import 'package:flutter/material.dart';

import '../../../../../ui/colors/colors.dart';

class ExtraInfo extends StatelessWidget {
  final String? value;
  final String infoName;
  const ExtraInfo({
    Key? key,
    required this.infoName,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final theme = Theme.of(context);
    //
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: size.width,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Text(
            infoName,
            style: const TextStyle(
              fontFamily: 'Inter',fontSize: 14, color: AppColors.mainGrey),
          ),
          // Expanded(child: Container()),
          Text(
            value!,
            style: TextStyle(
              fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.primaryColor),
          )
        ],
      ),
    );
  }
}