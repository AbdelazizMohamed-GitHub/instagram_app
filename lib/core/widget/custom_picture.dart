// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomPicture extends StatelessWidget {
  const CustomPicture({
    super.key,
    required this.image,
    this.radius = 120,
  });
  final Widget image;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius,
      width: radius,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(
          100,
        ),
        child: image,
      ),
    );
  }
}
