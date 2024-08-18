// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/service/app_service.dart';
import 'package:instagram_app/core/waring/waring.dart';
import 'package:instagram_app/core/widget/custom_button.dart';
import 'package:instagram_app/features/auth/data/model/user_model.dart';
import 'package:instagram_app/features/home/data/models/post_model.dart';
import 'package:instagram_app/features/profile/data/repo_impl/profile_repo_imp.dart';
import 'package:instagram_app/features/profile/presention/cubits/cubit/profile_cubit.dart';
import 'package:instagram_app/features/profile/presention/view/edit_profile_screen.dart';
import 'package:instagram_app/features/profile/presention/view/widget/custom_post_list.dart';
import 'package:instagram_app/features/profile/presention/view/widget/custom_profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
  final String uid;
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? currentUser;
  List<PostModel> postList = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(profileRepo: ProfileRepoImpl())..getUserData(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            widget.uid == FirebaseAuth.instance.currentUser!.uid
                ? IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("Are you sure?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      AuthService.signOut(context);
                                    },
                                    child: Text("Logout")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"))
                              ],
                            );
                          });
                      //AuthService.signOut(context);
                    },
                    icon: Icon(Icons.logout_sharp))
                : Container(),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: SafeArea(
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (snapshot.hasData || snapshot.data != null) {
                  UserModel user = UserModel.toGetData(snapshot.data!);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              CustomProfileHeader(user: user, posts: postList,),
                              SizedBox(
                                height: 15,
                              ),
                              FirebaseAuth.instance.currentUser!.uid !=
                                      widget.uid
                                  ? BlocConsumer<ProfileCubit, ProfileState>(
                                      listener: (context, state) {
                                        if (state is ProfileSucess) {
                                          currentUser = state.userModel;
                                        }
                                        if (state is ProfileFailure) {
                                          snackbar(context, state.error);
                                        }
                                      },
                                      builder: (context, state) {
                                        return state is ProfileLoading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : CustomButton(
                                                onPressed: () async {
                                                  context
                                                      .read<ProfileCubit>()
                                                      .followUser(
                                                          uid: widget.uid,
                                                          following:
                                                              currentUser!
                                                                      .following
                                                                  as List);
                                                  context
                                                      .read<ProfileCubit>()
                                                      .getUserData();
                                                },
                                                text: currentUser!.following!
                                                        .contains(widget.uid)
                                                    ? "Unfollow"
                                                    : "follow",
                                              );
                                      },
                                    )
                                  : CustomButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfileScreen(
                                                      userName: user.username,
                                                      photoUrl:
                                                          user.profilePictureUrl ??
                                                              '',
                                                      bio: user.bio,
                                                    )));
                                      },
                                      text: "Edit Profile"),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.black),
                        SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('posts')
                                .where('userId', isEqualTo: widget.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text("Error: ${snapshot.error}"),
                                );
                              }
                              if (snapshot.hasData || snapshot.data != null) {

                                final posts = snapshot.data!.docs.map((doc) {
                                  return PostModel.fromMap(
                                    doc.data() as Map<String, dynamic>,
                                  );
                                }).toList();
                                postList = posts;

                                return CustomPostList(posts: posts);
                              }
                              return SizedBox();
                            })
                      ],
                    ),
                  );
                }
                return SizedBox();
              }),
        ),
      ),
    );
  }
}
