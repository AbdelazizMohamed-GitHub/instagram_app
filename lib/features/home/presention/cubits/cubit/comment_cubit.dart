import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/home/domain/repo/comment_repo.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit({required this.commentRepo}) : super(CommentInitial());
  final CommentRepo commentRepo;
  int? commentLength = 0;
  static CommentCubit get(context) => BlocProvider.of(context);
  Future<void> addComment({
    required String comment,
    required String postId,
  }) async {
    emit(CommentLoading());
    var result = await commentRepo.addComments(
      comment: comment,
      postId: postId,
    );
    await Future.delayed(const Duration(seconds: 10));

    result.fold((error) => emit(CommentFailure(error.message)),
        (r) => emit(CommentSuccess()));
  }

  getCommentLength({required String postId}) async {
    QuerySnapshot doc = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();
    emit(CommentLoading());
    commentLength = doc.docs.length;
    emit(CommentSuccess());
    return doc.docs.length;
  }

  Future<void> deleteComment({
    required String commentId,
    required String postId,
  }) async {
    emit(DeletCommentLoading());
    var result = await commentRepo.deleteComment(
      commentId: commentId,
      postId: postId,
    );
    result.fold((error) => emit(CommentFailure(error.message)),
        (r) => emit(DeletCommentSuccess()));
  }
}
