import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_app/core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<AuthFailure, User>> registerWithEmailAndPassword(
      {required String email, required String password, required String name});
  Future<Either<AuthFailure, User>> loginWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signOut(context);

  Future<void> resetPassword({required String email});

  Future<Either<AuthFailure, UserCredential>> loginWithFacebook();
}
