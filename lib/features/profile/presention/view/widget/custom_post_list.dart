import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:instagram_app/features/home/data/models/post_model.dart';
import 'package:instagram_app/features/profile/presention/view/widget/custom_profile_posts_list.dart';

class CustomPostList extends StatelessWidget {
  const CustomPostList({
    super.key,
    required this.posts,
  });
  final List<PostModel> posts;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomProfilePostsList(post: posts)));
      },
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: posts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 3),
        itemBuilder: (BuildContext context, int index) {
          return CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: posts[index].imageUrl.toString(),
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        },
      ),
    );
  }
}
