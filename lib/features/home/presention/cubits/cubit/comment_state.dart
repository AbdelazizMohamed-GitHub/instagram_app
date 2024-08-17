part of 'comment_cubit.dart';

sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}
final class DeletCommentLoading extends CommentState {}

final class CommentSuccess extends CommentState {}
final class DeletCommentSuccess extends CommentState {}

final class CommentFailure extends CommentState {
  final String error;
  CommentFailure(this.error);
}

