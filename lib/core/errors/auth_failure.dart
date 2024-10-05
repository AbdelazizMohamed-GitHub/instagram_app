import 'package:instagram_app/core/errors/failure.dart';


class AuthFailure extends Failure {
   AuthFailure(String message) : super(message: message);

  factory AuthFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return AuthFailure('Email address is not valid.');
      case 'user-disabled':
        return AuthFailure('This user has been disabled.');
      case 'user-not-found':
        return AuthFailure('No user found with this email.');
      case 'wrong-password':
        return AuthFailure('Wrong password provided.');
      case 'email-already-in-use':
        return AuthFailure('This email is already in use.');
      case 'operation-not-allowed':
        return AuthFailure('Operation not allowed.');
      case 'weak-password':
        return AuthFailure('Password is too weak.');
      case "user-mismatch":
        return AuthFailure('User Mismatch');
      case "invalid-credential":
        return AuthFailure('Incorrect Email or Password');
      case "network-request-failed":
        return AuthFailure('No Internet Connection');
      default:
        return AuthFailure('An unknown error occurred.123');
    }
  }
}
