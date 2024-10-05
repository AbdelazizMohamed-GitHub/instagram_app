import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_app/core/errors/auth_failure.dart';
import 'package:instagram_app/core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> registerWithEmailAndPassword(
      {required String email, required String password, required String name});
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String email, required String password});

  Future<void> resetPassword({required String email});

  Future<Either<Failure, UserCredential>> loginWithFacebook();
}
