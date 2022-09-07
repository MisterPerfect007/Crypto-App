
import 'package:flutter/material.dart';

import '../../ui/colors/colors.dart';
import '../../ui/icons/svg-icons.dart';

class BottomBarItem extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final SvgIcons icon;
  final Color color;
  const BottomBarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        splashColor: AppColors.mainGreen.withOpacity(0.5),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcon(icon: icon, size: 18, color: color),
              Text(
                label,
                style: TextStyle(fontSize: 9, color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
