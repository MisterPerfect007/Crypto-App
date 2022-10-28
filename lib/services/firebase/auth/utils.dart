import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential?> googleLoginAndRegister() async {
  final googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  if (googleUser == null) return null;

  final googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  try {
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on FirebaseAuthException catch (e) {
    print("error code ::${e.code}");
  }
  return null;
}

Future<UserCredential?> facebookLoginAndRegister() async {
  final LoginResult loginResult = await FacebookAuth.instance.login();
  // final userData = await FacebookAuth.instance.getUserData();

  final credential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  try {
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on FirebaseAuthException catch (e) {
    print("error code ::${e.code}");
  }
  return null;
}
