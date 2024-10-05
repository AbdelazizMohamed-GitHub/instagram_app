import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/core/errors/firestore_failure.dart';
import 'package:instagram_app/core/utils/app_images.dart';
import 'package:instagram_app/core/utils/funcation.dart';
import 'package:instagram_app/core/waring/waring.dart';
import 'package:instagram_app/features/auth/data/model/user_model.dart';
import 'package:instagram_app/features/home/data/models/post_model.dart';
import 'package:instagram_app/features/home/presention/view/widget/custom_post_item.dart';
import 'package:instagram_app/features/profile/data/repo_impl/profile_repo_imp.dart';
import 'package:instagram_app/features/profile/presention/cubits/cubit/profile_cubit.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  UserModel? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            ProfileCubit(profileRepo: getIt.get<ProfileRepoImpl>())
              ..getUserData(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileFailure) {
              snackbar(context, state.error);
            }
            if (state is ProfileSucess) {
              user = state.userModel;
            }
          },
          builder: (context, state) {
            return state is ProfileLoading
                ? const Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 200,
                                child: SvgPicture.asset(
                                  AppImages.instagramWord,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const Spacer(),
                              SvgPicture.asset(AppImages.massanger)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // CustomStoryList(),
                        const Divider(thickness: 1, color: Colors.black),
                        StreamBuilder<QuerySnapshot?>(
                            stream: user?.following?.isNotEmpty ?? false
                                ? FirebaseFirestore.instance
                                    .collection('posts')
                                    .where('userId',
                                        whereIn: user?.following ?? [])
                                    .orderBy('timestamp', descending: true)
                                    .snapshots()
                                : FirebaseFirestore.instance
                                    .collection('posts')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                final error = snapshot.error;

                                if (error is FirebaseException) {
                                  final errorCode = error.code;
                                  return Center(
                                    child: Text(FirestoreFailure.fromCode(
                                            errorCode as FirebaseException)
                                        .message),
                                  );
                                }

                                return Text(error.toString());
                              }
                              if (snapshot.data!.docs.isEmpty) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 300,
                                    ),
                                    Text(
                                      'No Posts Follow Your Freinds',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                );
                              }
                              if (snapshot.hasData) {
                                final post = snapshot.data!.docs.map((doc) {
                                  return PostModel.fromMap(
                                    doc.data() as Map<String, dynamic>,
                                  );
                                }).toList();

                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: post.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                        thickness: 1, color: Colors.black);
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CustomPostItem(
                                      post: post,
                                      index: index,
                                    );
                                  },
                                );
                              }

                              return Container();
                            }),
                      ]),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
