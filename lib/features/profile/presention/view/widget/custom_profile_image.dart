

import 'package:cached_network_image/cached_network_image.dart';
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
            : CustomPicture(
                image: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )),
      ],
    );
  }
}
