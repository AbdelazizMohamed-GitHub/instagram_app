import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instagram_app/core/errors/failure.dart';
import 'package:instagram_app/core/errors/firestore_failure.dart';
import 'package:instagram_app/core/service/firestore_service.dart';
import 'package:instagram_app/features/home/domain/repo/comment_repo.dart';

class CommentRepoimpl extends CommentRepo {
  final FireStoreService fireStoreService;
  @override
  CommentRepoimpl({required this.fireStoreService});
  Future<Either<Failure, void>> addComments({required String comment, required String postId})async {
   try{
  var result= await fireStoreService.addComment(postId: postId, comment: comment);
     return right(result);
   }on FirebaseException catch(e){
    return left(FirestoreFailure.fromCode(e));
   }
  }
  
  @override
  Future<Either<Failure, void>> deleteComment({required String postId, required String commentId})async {
try{
  var result=await fireStoreService.deleteComments(postId: postId, cId: commentId);
  return right(result);
}on FirebaseException catch(e){
  return left(FirestoreFailure.fromCode(e));
  
}
  }
  
}