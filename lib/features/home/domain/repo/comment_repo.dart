import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/failure.dart';

abstract class CommentRepo {
  Future<Either<Failure, void>> addComments({
    required String comment,
    required String postId,
  });

  Future<Either<Failure, void>> deleteComment({
    required String postId,
    required String commentId,});
}
