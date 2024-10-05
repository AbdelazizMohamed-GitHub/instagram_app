import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_app/core/errors/failure.dart';

class FirestoreFailure extends Failure {
  FirestoreFailure(String message) : super(message: message);
  factory FirestoreFailure.fromCode(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return FirestoreFailure('Permission denied. Please try again later.');
      case 'unavailable':
        return FirestoreFailure(
            'The Firestore service is currently unavailable. Please try again later.');
      case 'deadline-exceeded':
        return FirestoreFailure(
            'The operation took too long to complete. Please try again.');
      case 'not-found':
        return FirestoreFailure(
            'The requested document or collection was not found.');
      case 'already-exists':
        return FirestoreFailure('The document already exists.');
      case 'cancelled':
        return FirestoreFailure('The operation was cancelled.');
      case 'data-loss':
        return FirestoreFailure('Data loss occurred. Please try again.');
      case 'invalid-argument':
        return FirestoreFailure(
            'An invalid argument was provided. Please check your inputs.');
      case 'resource-exhausted':
        return FirestoreFailure(
            'Resource exhausted. Too many requests or quota exceeded.');
      case 'failed-precondition':
        return FirestoreFailure(
            'Operation was rejected due to failed precondition.');
      case 'out-of-range':
        return FirestoreFailure(
            'Operation was attempted outside of the valid range.');
      case 'unimplemented':
        return FirestoreFailure(
            'The operation is not implemented or supported.');
      case 'internal':
        return FirestoreFailure(
            'An internal error occurred. Please try again later.');
      case 'unauthenticated':
        return FirestoreFailure(
            'You need to be authenticated to perform this action.');
      case 'object-not-found':
        return FirestoreFailure('The requested object was not found.');
      default:
        return FirestoreFailure('An unknown error occurred. Please try again.');
    }
  }
}
