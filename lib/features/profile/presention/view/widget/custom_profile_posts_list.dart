// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:instagram_app/features/home/data/models/post_model.dart';

import 'package:instagram_app/features/home/presention/view/widget/custom_post_item.dart';

class CustomProfilePostsList extends StatelessWidget {
  const CustomProfilePostsList({
    super.key,
    required this.post,
  });
  final List<PostModel> post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: Text(post[0].username.toString())),
      body: ListView.separated(
          padding: const EdgeInsets.only(top: 10),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CustomPostItem(
              post: post,
              index: index,
            );
          },
          separatorBuilder: (context, index) => const Divider(
                thickness: 1,
              ),
          itemCount: post.length),
    );
  }
}
