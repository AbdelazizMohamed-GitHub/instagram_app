// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:instagram_app/features/auth/data/model/user_model.dart';
import 'package:instagram_app/features/profile/presention/view/widget/custom_profile_image.dart';
import 'package:instagram_app/features/profile/presention/view/widget/custom_profile_top_information.dart';

class CustomProfileHeader extends StatelessWidget {
  const CustomProfileHeader({
    super.key,
    required this.user,
    required this.posts,
  });
  final UserModel user;
  final List posts;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            CustomProfilePicture(
              imageUrl: "${user.profilePictureUrl}",
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 100,
              child: Text(
                user.username,
                overflow: TextOverflow.visible,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              user.bio,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ],
        ),
         CustomProfileTopInformation(number: posts.length.toString(), text: "Posts"),
        CustomProfileTopInformation(
            number: user.followers!.length.toString(), text: "Followers"),
        CustomProfileTopInformation(
            number: user.following!.length.toString(), text: "Following"),
      ],
    );
  }
}
