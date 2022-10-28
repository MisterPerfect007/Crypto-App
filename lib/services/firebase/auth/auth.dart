import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  final FirebaseAuth auth;
  FireAuth(this.auth);

  Future<Either<UserCredential, String>> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //! User should verify his email
      userCredential.user?.sendEmailVerification();
          print(userCredential);
      return Left(userCredential);
    } on FirebaseAuthException catch (e) {
      print("Error>>>>>> ${e.code}");
      return Right(e.code);
    }
  }
  Future<Either<UserCredential, String>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>$userCredential");
      return Left(userCredential);
    } on FirebaseAuthException catch (e) {
      print("Error>>>>>> ${e.code}");
      return Right(e.code);
    }
  }
}
