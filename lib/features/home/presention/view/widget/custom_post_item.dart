import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/utils/funcation.dart';
import 'package:instagram_app/core/widget/custom_picture.dart';

import 'package:instagram_app/features/home/data/models/post_model.dart';
import 'package:instagram_app/features/home/data/repo_impl/comment_repo_impl.dart';
import 'package:instagram_app/features/home/presention/cubits/cubit/comment_cubit.dart';
import 'package:instagram_app/features/home/presention/cubits/post_cubit/post_cubit.dart';
import 'package:instagram_app/features/home/presention/view/comments_screen.dart';

class CustomPostItem extends StatelessWidget {
  const CustomPostItem({
    super.key,
    required this.post,
    required this.index,
  });
  final List<PostModel> post;
  final int index;
  @override
  Widget build(BuildContext context) {
    return 
       
        BlocProvider<CommentCubit>(
          create: (context) => CommentCubit(commentRepo: getIt.get<CommentRepoimpl>())
            ..getCommentLength(postId: post[index].postId.toString()),
        
     
      child: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          return Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      CustomPicture(
                        radius: 60,
                        image: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: post[index].profilePictureUrl.toString(),
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: 200,
                          child: Text(post[index].username.toString())),
                      const Spacer(),
                      post[index].userId ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? IconButton(
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text(
                                            "Are you sure you want to delete this post?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                await context
                                                    .read<PostCubit>()
                                                    .deletePosts(
                                                        postId: post[index]
                                                            .postId
                                                            .toString(),
                                                        imageUrl: post[index]
                                                            .imageUrl
                                                            .toString());
                                                            
                                              },
                                              child: const Text("Delete")),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.more_vert),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onDoubleTap: () {
                      context.read<PostCubit>().likePosts(
                            postId: post[index].postId.toString(),
                            uid: FirebaseAuth.instance.currentUser!.uid,
                            likes: post[index].likes ?? [],
                          );
                    },
                    child: SizedBox(
                      height: 400,
                      child: CachedNetworkImage(
                        imageUrl: post[index].imageUrl.toString(),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          IconButton(
                              onPressed: () async {
                                await context.read<PostCubit>().likePosts(
                                      postId: post[index].postId.toString(),
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      likes: post[index].likes ?? [],
                                    );
                              },
                              icon: post[index].likes!.contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? const Icon(Icons.favorite,
                                      color: Colors.red)
                                  : const Icon(Icons.favorite_border)),
                          const SizedBox(
                            width: 15,
                          ),
                          BlocBuilder<CommentCubit, CommentState>(
                            builder: (context, state) {
                              return Text(
                                  "${context.read<CommentCubit>().commentLength}");
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                showBottomSheet(
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return CommentsScreen(
                                        postId: post[index].postId.toString(),
                                      );
                                    });
                                // Navigator.pushNamed(
                                //     context, AppRouter.commentsScreenRoute,
                                //     arguments: post[index].postId);
                              },
                              icon: const Icon(Icons.comment)),
                          const SizedBox(
                            width: 15,
                          ),
                          const Icon(Icons.send),
                          const Spacer(),
                          const Icon(Icons.bookmark_border),
                          const SizedBox(
                            width: 20,
                          )
                        ]),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text("Liked by"),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${post[index].likes!.length}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              post[index].username.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text("${post[index].caption}"),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        const Text(
                          "View all comments",
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
