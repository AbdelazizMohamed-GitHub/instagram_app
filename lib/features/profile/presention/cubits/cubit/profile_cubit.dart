import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/auth/data/model/user_model.dart';
import 'package:instagram_app/features/profile/domain/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());
  ProfileRepo profileRepo;
  static ProfileCubit get(context) => BlocProvider.of<ProfileCubit>(context);
  Future<void> updateUserProfileWithImage({
    required Uint8List imageFile,
    required String username,
    required String bio,
  }) async {
    emit(EditProfileLoading());
    var result = await profileRepo.updateUserProfileWithImage(
      imageFile: imageFile,
      username: username,
      bio: bio,
    );
    result.fold((error) => emit(EditProfileFailure(error.message)),
        (r) => emit(EditProfileSucess()));
  }

  Future<void> updateUserProfileWithoutImage({
    required String username,
    required String bio,
  }) async {
    emit(EditProfileLoading());
    var result = await profileRepo.updateUserProfileWithoutImage(
      username: username,
      bio: bio,
    );
    result.fold((error) => emit(EditProfileFailure(error.message)),
        (r) => emit(EditProfileSucess()));
  }

  Future<void> getUserData() async {
    emit(ProfileLoading());
    var result = await profileRepo.getUserData(uid: FirebaseAuth.instance.currentUser!.uid);

    result.fold((error) => emit(ProfileFailure(error.message)),
        (user) => emit(ProfileSucess(userModel: user)));
  }

  Future<void> followUser(
      {required String uid, required List following}) async {
    emit(FollowUserLoading());
    var result = await profileRepo.followUser(uid: uid, following: following);
    result.fold((error) => emit(FollowUserFailure(error.message)),
        (r) => emit(FollowUserSuccess()));
  }
}
