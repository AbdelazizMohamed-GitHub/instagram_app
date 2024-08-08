

import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  RegisterSuccess(User user);
}

class RegisterError extends RegisterState {
  final String message;

  RegisterError(this.message);
}
