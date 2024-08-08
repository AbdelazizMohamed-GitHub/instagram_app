import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess(User user);
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}
