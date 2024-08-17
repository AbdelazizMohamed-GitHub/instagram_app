// ignore_for_file: void_checks

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/firestore_failure.dart';
import 'package:instagram_app/core/service/firestore_service.dart';
import 'package:instagram_app/features/home/domain/repo/post_repo.dart';

class PostRepoImpl extends PostRepo {
  @override
  Future<Either<FirestoreFailure, void>> addPosts(
      {required String caption, required Uint8List imageFile}) async {
    try {
      await FireStoreService.addPost(caption: caption, imageFile: imageFile);
      return right("Sucessfully Added");
    } on FirebaseException catch (e) {
      return left(FirestoreFailure.fromCode(e));
    }
  }

  @override
  Future<Either<FirestoreFailure, void>> likePosts(
      {required String postId,
      required String uid,
      required List likes}) async {
    try {
      var result = await FireStoreService.likePosts(
          postId: postId, uId: uid, likes: likes);
      return right(result);
    } on FirebaseException catch (e) {
      return left(FirestoreFailure.fromCode(e));
    }
  }

  @override
  Future<Either<FirestoreFailure, void>> deletePost({required String postId,required String imageUrl}) async{
    try {
   var result= await  FireStoreService.deletePost(postId: postId, imagUrl: imageUrl);
   return right(result);
    } on FirebaseException catch (e) {
      return left(FirestoreFailure.fromCode(e));
    }
  }
}