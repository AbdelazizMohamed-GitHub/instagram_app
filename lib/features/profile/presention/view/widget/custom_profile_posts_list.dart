import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/home/data/models/post_model.dart';
import 'package:instagram_app/features/home/presention/cubits/post_cubit/post_cubit.dart';

import 'package:instagram_app/features/home/presention/view/widget/custom_post_item.dart';

class CustomProfilePostsList extends StatefulWidget {
  const CustomProfilePostsList({
    super.key,
    required this.post,
  });
  final List<PostModel> post;

  @override
  State<CustomProfilePostsList> createState() => _CustomProfilePostsListState();
}

class _CustomProfilePostsListState extends State<CustomProfilePostsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: Text(widget.post[0].username.toString())),
      body: BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {
          if (state is PostSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return state is PostLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 10),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CustomPostItem(
                      post: widget.post,
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                      ),
                  itemCount: widget.post.length);
        },
      ),
    );
  }
}
