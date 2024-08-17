// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_app/core/errors/firestore_failure.dart';
import 'package:instagram_app/features/auth/data/model/user_model.dart';

abstract class ProfileRepo {

  Future<Either<FirestoreFailure, UserModel>> getUserData({required String uid});
  Future<Either<FirestoreFailure, void>> updateUserProfileWithImage({
   required  Uint8List imageFile,
    required String username,
    required String bio,
  });
   Future<Either<FirestoreFailure, void>> updateUserProfileWithoutImage({
  
    required String username,
    required String bio,
  });
  Future<Either<FirestoreFailure,void>> followUser({required String uid,required List following});


}
