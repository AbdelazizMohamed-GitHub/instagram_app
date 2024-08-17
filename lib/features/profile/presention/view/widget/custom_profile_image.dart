// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';

import 'package:instagram_app/core/utils/app_images.dart';
import 'package:instagram_app/core/widget/custom_picture.dart';

class CustomProfilePicture extends StatelessWidget {
  final String imageUrl;

  const CustomProfilePicture({super.key, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageUrl == ''
            ? CustomPicture(image: Image.asset(AppImages.emptyUser))
            : CustomPicture(image: Image.network(imageUrl)),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.add_a_photo),
                onPressed: () async {},
              )),
        ),
      ],
    );
  }
}
