import 'package:flutter/widgets.dart';

import '../../features/favorites/utils/utils.dart';
import '../../features/loginAndRegister/utils/utils.dart';
import '../../services/firebase/auth/utils.dart';

addOrRemoveFavorite(BuildContext context, String id) {
  //
  final String? userUid = getUserUid();
  //check if user is loged in
  if (userUid == null) {
    //User should logged in
    showCustomDialog(
      context,
      type: CustomDialog.warning,
      bodyText: 'Log in and enjoy',
      onSubmit: () {},
      submitText: 'Log in',
      title: 'You are not Logged in',
    );
  } else {
    handleFavorite(userUid, id);
  }
}
