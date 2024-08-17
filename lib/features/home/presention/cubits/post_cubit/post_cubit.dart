import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/home/domain/repo/post_repo.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.postRepo}) : super(PostInitial());
  PostRepo postRepo;
  static PostCubit get(context) => BlocProvider.of(context);
  Future<void> addPosts(
      {required String caption, required Uint8List imageFile}) async {
    emit(PostLoading());
    var result =
        await postRepo.addPosts(caption: caption, imageFile: imageFile);
    result.fold((error) => emit(PostFailure(error.message)),
        (r) => emit(PostSuccess()));
  }

  Future<void> likePosts(
      {required String postId,
      required String uid,
      required List likes}) async {
    emit(PostLoading());
    var result =
        await postRepo.likePosts(postId: postId, uid: uid, likes: likes);
    result.fold((error) => emit(PostFailure(error.message)),
        (r) => emit(PostSuccess()));
  }

  Future<void> deletePosts(
      {required String postId, required String imageUrl}) async {
    emit(PostLoading());
    var result = await postRepo.deletePost(postId: postId, imageUrl: imageUrl);
    result.fold((error) => emit(PostFailure(error.message)),
        (r) => emit(PostSuccess()));
  }
}
