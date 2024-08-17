// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/home/presention/cubits/cubit/comment_cubit.dart';

import '../../../../../core/widget/custom_picture.dart';

class CustomCommentList extends StatelessWidget {
  const CustomCommentList({
    Key? key,
    required this.comments,
    required this.postId,
  }) : super(key: key);
final List comments;
final String postId;
  @override
  Widget build(BuildContext context) {
    return Expanded(
                                  child: SizedBox(
                                    child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: comments.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Divider(
                                            thickness: 1, color: Colors.black);
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          height: 100,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade200),
                                          child: Row(
                                            children: [
                                              CustomPicture(
                                                image: Image.network(
                                                    comments[index]
                                                        .profilePictureUrl
                                                        .toString()),
                                                radius: 80,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(comments[index]
                                                      .username
                                                      .toString()),
                                                  Text(comments[index]
                                                      .comment
                                                      .toString())
                                                ],
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                  onPressed: () async {
                                                    await context
                                                        .read<CommentCubit>()
                                                        .deleteComment(
                                                            postId: postId,
                                                            commentId: comments[
                                                                    index]
                                                                .commentId
                                                                .toString());
                                                  },
                                                  icon: const Icon(
                                                      Icons.more_vert))
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
  }
}
