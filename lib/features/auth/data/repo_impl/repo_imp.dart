import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:instagram_app/core/errors/auth_failure.dart';
import 'package:instagram_app/core/errors/failure.dart';
import 'package:instagram_app/features/auth/data/model/user_model.dart';
import 'package:instagram_app/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
    
      return left(AuthFailure.fromCode(e.code));
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        username: name,
        email: email,
        profilePictureUrl: '',
        bio: '',
        followers: [],
        following: [],
      );
      firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toUpload());

      return right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return left(AuthFailure('An unknown error occurred.'));
    }
  }

  @override
  @override
  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    // Navigator.pushReplacementNamed(context, AppRouter.loginScreenRoute);
  }

  @override
  Future<Either<Failure, UserCredential>> loginWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;

        // استخدام Facebook credential للتسجيل في Firebase
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        UserModel user = UserModel(
          id: userCredential.user!.uid,
          username: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
          profilePictureUrl: userCredential.user!.photoURL!,
          bio: '',
          followers: [],
          following: [],
        );
        firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toUpload());
        return right(userCredential);
      }
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return left(AuthFailure('An unknown error occurred.'));
    }
    return left(AuthFailure('An unknown error occurred.'));
  }
}
