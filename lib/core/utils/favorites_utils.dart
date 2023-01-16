import 'package:crypto_trends/features/loginAndRegister/presenter/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:crypto_trends/injection_container.dart' as di;

import '../../features/favorites/utils/utils.dart';
import '../../features/loginAndRegister/utils/utils.dart';
import '../../services/firebase/auth/utils.dart';
import '../network/network_info.dart';
import '../widgets/toast/toast.dart';

addOrRemoveFavorite(BuildContext context, String id) async {
  //
  if (await di.sl<NetworkInfo>().isConnected) {
    final String? userUid = getUserUid();
    //check if user is loged in
    if (userUid == null) {
      //User should logged in
      showCustomDialog(
        context,
        type: CustomDialog.warning,
        bodyText: 'Log in or Register to add favorites',
        onSubmit: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage())),
        submitText: 'Log in or Register',
        title: 'You are not Logged in',
        cancelText: 'No',
        onCancel: (){}
      );
    } else {
      handleFavorite(userUid, id);
    }
  } else {
    CustomToast.defaultToast(context, "No internet connection");
  }
}
