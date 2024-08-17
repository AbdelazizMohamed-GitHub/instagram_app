import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/firestore_failure.dart';

abstract class CommentRepo {
  Future<Either<FirestoreFailure, void>> addComments({
    required String comment,
    required String postId,
  });

  Future<Either<FirestoreFailure, void>> deleteComment({
    required String postId,
    required String commentId,});
}
