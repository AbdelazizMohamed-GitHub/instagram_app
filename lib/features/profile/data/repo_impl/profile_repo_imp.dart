import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_app/core/errors/firestore_failure.dart';
import 'package:instagram_app/core/service/firestore_service.dart';
import 'package:instagram_app/features/auth/data/model/user_model.dart';
import 'package:instagram_app/features/profile/domain/repo/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final FireStoreService fireStoreService;
  ProfileRepoImpl({required this.fireStoreService});
  @override
  Future<Either<FirestoreFailure, void>> updateUserProfileWithImage({
    required Uint8List imageFile,
    required String username,
    required String bio,
  }) async {
    try {
      await fireStoreService.updateUserProfileWithImage(
        username: username,
        imageFile: imageFile,
        bio: bio,
      );
      // ignore: void_checks
      return right("Sucessfully Updated");
    } on FirebaseException catch (e) {
      return left(FirestoreFailure.fromCode(e));
    }
  }

  @override
  Future<Either<FirestoreFailure, void>> updateUserProfileWithoutImage({
    required String username,
    required String bio,
  }) async {
    try {
      await fireStoreService.updateUserProfile(
        username: username,
        bio: bio,
      );
      // ignore: void_checks
      return right("Sucessfully Updated");
    } on FirebaseException catch (e) {
      return left(FirestoreFailure.fromCode(e));
    } on Exception catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<FirestoreFailure, UserModel>> getUserData(
      {required String uid}) async {
    try {
      UserModel user = await fireStoreService.getUserData(userId: uid);
      return right(user);
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<FirestoreFailure, void>> followUser(
      {required String uid, required List following}) async {
    try {
      var rseult = await fireStoreService.followUser(
          userId: uid, following: following );
      return right(rseult);
    } on FirebaseException catch (e) {
      return left(FirestoreFailure.fromCode(e));
    }
  }
}
