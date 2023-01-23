import 'package:flutter/material.dart';


import '../../../../core/widgets/navigation/go_back_widget.dart';
import '../../../../ui/colors/colors.dart';

class SeeAllPageAppBar extends StatelessWidget {
  const SeeAllPageAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double sidePadding = width / 25;
    //
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 0, right: sidePadding),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.mainGrey.withOpacity(0.1),
                offset: const Offset(0, 1),
                blurRadius: 0.5,
                spreadRadius: 0),
          ],
        ),
        child: Row(
          children: [
            const GoBack(),
            Expanded(
              child: Text(
                title,
                
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
            fontFamily: 'Inter',
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
