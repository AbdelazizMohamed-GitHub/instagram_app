// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/core/utils/app_images.dart';
import 'package:instagram_app/core/waring/waring.dart';
import 'package:instagram_app/features/auth/data/model/user_model.dart';
import 'package:instagram_app/features/home/data/models/post_model.dart';
import 'package:instagram_app/features/home/presention/view/widget/custom_post_item.dart';
import 'package:instagram_app/features/home/presention/view/widget/custom_story_list.dart';
import 'package:instagram_app/features/profile/data/repo_impl/profile_repo_imp.dart';
import 'package:instagram_app/features/profile/presention/cubits/cubit/profile_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  UserModel? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) =>
          ProfileCubit(profileRepo: ProfileRepoImpl())..getUserData(),
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
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
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
                          Spacer(),
                          SvgPicture.asset(AppImages.massanger)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomStoryList(),
                    const Divider(thickness: 1, color: Colors.black),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .where('userId', whereIn: user?.following)
                             .orderBy('timestamp', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Home Error: ${snapshot.error}'));
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No Posts Follow Freinds'),
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
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: post.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                    thickness: 1, color: Colors.black);
                              },
                              itemBuilder: (BuildContext context, int index) {
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
                ));
        },
      ),
    ));
  }
}
