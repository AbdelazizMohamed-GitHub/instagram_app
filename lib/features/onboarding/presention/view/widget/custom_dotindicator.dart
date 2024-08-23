import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:instagram_app/core/utils/app_colors.dart';

class CustomDotindicator extends StatelessWidget {
  const CustomDotindicator({
    super.key,
    required this.postion,
  });
  final int postion;
  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      decorator: const DotsDecorator(
        color: Colors.black,
        activeColor: AppColors.primaryColor,
        activeSize: Size(15, 15),
        activeShape: CircleBorder(),
      ),
      dotsCount: 3,
      position: postion,
    );
  }
}
