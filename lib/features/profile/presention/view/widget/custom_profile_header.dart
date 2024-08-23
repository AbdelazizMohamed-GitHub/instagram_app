import 'package:flutter/material.dart';

import 'package:instagram_app/features/auth/data/model/user_model.dart';
import 'package:instagram_app/features/profile/presention/view/widget/custom_profile_image.dart';
import 'package:instagram_app/features/profile/presention/view/widget/custom_profile_top_information.dart';

class CustomProfileHeader extends StatefulWidget {
  const CustomProfileHeader({
    super.key,
    required this.user,
    required this.posts,
  });
  final UserModel user;
  final List posts;

  @override
  State<CustomProfileHeader> createState() => _CustomProfileHeaderState();
}

class _CustomProfileHeaderState extends State<CustomProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomProfilePicture(
              imageUrl: "${widget.user.profilePictureUrl}",
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 100,
              child: Text(
                widget.user.username,
                overflow: TextOverflow.visible,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                widget.user.bio,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
        CustomProfileTopInformation(
            number: widget.posts.length.toString(), text: "Posts"),
        CustomProfileTopInformation(
            number: widget.user.followers!.length.toString(),
            text: "Followers"),
        CustomProfileTopInformation(
            number: widget.user.following!.length.toString(),
            text: "Following"),
      ],
    );
  }
}
