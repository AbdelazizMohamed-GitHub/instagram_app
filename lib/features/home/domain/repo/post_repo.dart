import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/failure.dart';

abstract class PostRepo {
  Future<Either<Failure, void>> addPosts(
      {required String caption, required Uint8List imageFile});

  Future<Either<Failure, void>> likePosts(
      {required String postId, required String uid, required List likes});

  Future<Either<Failure, void>> deletePost(
      {required String postId, required String imageUrl});
}
