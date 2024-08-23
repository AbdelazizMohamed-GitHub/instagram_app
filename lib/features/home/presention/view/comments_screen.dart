

// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instagram_app/core/waring/waring.dart';
import 'package:instagram_app/features/home/data/models/comment_model.dart';
import 'package:instagram_app/features/home/data/repo_impl/comment_repo_impl.dart';
import 'package:instagram_app/features/home/presention/cubits/cubit/comment_cubit.dart';
import 'package:instagram_app/features/home/presention/view/widget/custom_comment_list.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({
    super.key,
    required this.postId,
  });

  final String postId;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: BlocProvider(
            create: (context) => CommentCubit(commentRepo: CommentRepoimpl()),
            child: BlocConsumer<CommentCubit, CommentState>(
              listener: (context, state) {
                if (state is CommentFailure) {
                  snackbar(context, state.error);
                }
                if (state is CommentSuccess) {
                  snackbar(context, "Comment added successfully");
                  commentController.clear();
                  FocusScope.of(context).unfocus();
                }
              },
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: state is CommentLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('posts')
                                    .doc(postId)
                                    .collection('comments')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text("Error: ${snapshot.error}"));
                                  }
                                  if (snapshot.data!.docs.isEmpty) {
                                    return const Center(
                                        child: Text(
                                      "No comments yet",
                                      style: TextStyle(fontSize: 20),
                                    ));
                                  }
                                  final comments =
                                      snapshot.data!.docs.map((doc) {
                                    return CommentModel.fromMap(
                                      doc.data() as Map<String, dynamic>,
                                    );
                                  }).toList();

                                  return CustomCommentList(
                                      comments: comments, postId: postId);
                                }),
                            const Expanded(
                                child: SizedBox(
                              height: 20,
                            )),
                            TextFormField(
                              autofocus: true,
                              controller: commentController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Write a comment",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      if (commentController.text.isNotEmpty) {
                                        CommentCubit.get(context).addComment(
                                            comment: commentController.text,
                                            postId: postId);
                                      }
                                    },
                                    icon: const Icon(Icons.send)),
                              ),
                            )
                          ],
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
