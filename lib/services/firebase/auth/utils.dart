import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

List<String> defaultError = [
  "Sign In failed",
  "Something went wrong. You should try again"
];

Future<Either<List<String>, UserCredential>> googleLoginAndRegister() async {
  final googleSignIn = GoogleSignIn();
  final firebaseAuth = FirebaseAuth.instance;
  //! should wrap in try{} catch block
  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return Left(defaultError);
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Error firebase ::: ${e.code}");
      return Left(errorMsgFromCode(e.code));
    }
  } catch (e) {
    //
    // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Error google --> 1 try");
  }
  return Left(defaultError);
}

Future<Either<List<String>, UserCredential>> facebookLoginAndRegister() async {
  // try {
  //
  final LoginResult loginResult = await FacebookAuth.instance.login();
  // loginResult.status
  if(loginResult.status != LoginStatus.success){
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> login failed ><<<<<<<<<<<<<<<<<<<<<<<<<<<<");

  }
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> status: ${loginResult.status}");
  print(
      ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Error facebook accessToken :: ${loginResult}");
  //
  if (loginResult.accessToken == null) {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> accessToken = null");
    return Left(defaultError);
  }


  final credential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);
  // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Error credential:: ${credential}");
  try {
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return Right(userCredential);
  } on FirebaseAuthException catch (e) {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Error firebase:: ${e.code}");
    return Left(errorMsgFromCode(e.code));
  }
  // } catch (e) {
  //   //
  // }
  return Left(defaultError);
}

List<String> errorMsgFromCode(String code) {
  List<String> errorMsg;
  switch (code) {
    case "account-exists-with-different-credential":
      errorMsg = [
        "Account exists with different credential",
        "It seems like you have already an account, try with it"
      ];
      break;
    case "operation-not-allowed":
      errorMsg = [
        "Operation not allowed",
        "It seems like this operation is not allowed for this account"
      ];
      break;
    case "user-disabled":
      errorMsg = [
        "Account disabled",
        "It seems like this account has been disabled"
      ];
      break;
    case "user-not-found":
      errorMsg = [
        "Account not found",
        "It seems like there is no user corresponding to the given email."
      ];
      break;
    default:
      errorMsg = defaultError;
  }
  return errorMsg;
}
