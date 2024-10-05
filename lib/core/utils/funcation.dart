import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_app/core/service/firestore_service.dart';
import 'package:instagram_app/features/home/data/repo_impl/comment_repo_impl.dart';
import 'package:instagram_app/features/home/data/repo_impl/post_repo_impl.dart';
import 'package:instagram_app/features/profile/data/repo_impl/profile_repo_imp.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> login() async {
  final prefs = await SharedPreferences.getInstance();
  // Set the login state
  await prefs.setBool('isLoggedIn', true);
}

Future<bool> checkLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  // Check if the user is logged in
  return prefs.getBool('isLoggedIn') ?? false;
}

final getIt = GetIt.instance;

void setupLocator() {
  // Register services or classes
  getIt.registerLazySingleton<PostRepoImpl>(() => PostRepoImpl(
      fireStoreService: FireStoreService(
          firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance)));
  getIt.registerLazySingleton<CommentRepoimpl>(() => CommentRepoimpl(
      fireStoreService: FireStoreService(
          firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance)));
  getIt.registerLazySingleton<ProfileRepoImpl>(() => ProfileRepoImpl(
      fireStoreService: FireStoreService(
          firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance)));
}
