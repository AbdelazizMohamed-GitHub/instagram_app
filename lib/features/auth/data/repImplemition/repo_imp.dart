import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_app/core/errors/failure.dart';
import 'package:instagram_app/core/utils/routs.dart';
import 'package:instagram_app/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either<AuthFailure, User>> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
     
      return left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return left(AuthFailure('An unknown error occurred.'));
    }
  }

  @override
  Future<Either<AuthFailure, User>> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return left(AuthFailure('An unknown error occurred.'));
    }
  }

  Future<void> signOut(context) async {
    await firebaseAuth.signOut();
    Navigator.pushReplacementNamed(context, AppRouter.loginScreenRoute);
  }
}
