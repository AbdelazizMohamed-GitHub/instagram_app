import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_app/core/errors/failure.dart';

abstract class AuthRepo {
 

  Future<Either<AuthFailure, User>> register(
      {required String email, required String password, required String name});
  Future<Either<AuthFailure, User>> login(
      {required String email, required String password });
}
