import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/firestore_failure.dart';

abstract class PostRepo {
  Future<Either<FirestoreFailure, void>> addPosts(
      {required String caption, required Uint8List imageFile});

  Future<Either<FirestoreFailure, void>> likePosts(
      {required String postId, required String uid, required List likes});

  Future<Either<FirestoreFailure, void>> deletePost(
      {required String postId, required String imageUrl});
}
