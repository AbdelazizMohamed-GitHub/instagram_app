
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:instagram_app/core/service/storge_service.dart';
import 'package:instagram_app/core/utils/app_images.dart';
import 'package:instagram_app/core/widget/custom_picture.dart';

class CustomEditProfileImge extends StatefulWidget {
  const CustomEditProfileImge({
    super.key,
    required this.photoUrl,
    required this.onChanged,
  });
  final String photoUrl;
  final ValueChanged<Uint8List?>? onChanged;
  @override
  State<CustomEditProfileImge> createState() => _CustomEditProfileImgeState();
}

class _CustomEditProfileImgeState extends State<CustomEditProfileImge> {
  Uint8List? imageFile;

  _CustomEditProfileImgeState();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageFile == null
            ? widget.photoUrl == ''
                ? CustomPicture(
                    image: Image.asset(
                      AppImages.emptyUser,
                      fit: BoxFit.cover,
                    ),
                  )
                : CustomPicture(
                    image: CachedNetworkImage(
                      imageUrl: widget.photoUrl,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
            : CustomPicture(
                image: Image.memory(imageFile!),
              ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.add_a_photo),
                onPressed: () async {
                  Uint8List? imag = await StorgeService.pickImageFromGallery();

                  setState(() {
                    imageFile = imag;
                    widget.onChanged?.call(imageFile);
                  });
                },
              )),
        ),
      ],
    );
  }
}
