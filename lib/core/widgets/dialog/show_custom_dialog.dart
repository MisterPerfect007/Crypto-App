import 'package:flutter/material.dart';

import '../../../ui/colors/colors.dart';

Future showCustomDialog(
  BuildContext context, {
  required CustomDialog type,
  required String title,
  required String bodyText,
  required String submitText,
  required Function() onSubmit,
  String? cancelText,
  Function()? onCancel,
}) async {
  double radius = 10;
  Color color;
  if (type == CustomDialog.success) {
    color = Colors.green;
  } else {
    color = type == CustomDialog.warning ? Colors.orange : Colors.red.shade400;
  }
  IconData icon;
  if (type == CustomDialog.success) {
    icon = Icons.verified;
  } else {
    icon = type == CustomDialog.warning ? Icons.warning : Icons.close;
  }
  //
  // final theme = Theme.of(context);
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                )),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.lightBg,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                const SizedBox(height: 20),
                Text(bodyText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await onSubmit();
                          Navigator.of(context).pop();
                        },
                        child: Text(submitText)),
                    if (onCancel != null)
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              onPressed: () async {
                                await onCancel();
                                Navigator.of(context).pop();
                              },
                              child: Text(cancelText ?? "")),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

enum CustomDialog { success, failed, warning }