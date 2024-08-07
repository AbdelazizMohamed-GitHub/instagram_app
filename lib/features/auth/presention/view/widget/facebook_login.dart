import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/app_colors.dart';
import 'package:instagram_app/core/utils/app_styles.dart';

class CustomFacebookLogin extends StatelessWidget {
  const CustomFacebookLogin({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.blue),
        child:
             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(text, style: AppStyles.text18Bold),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.facebook,
            color: Colors.white,
          )
        ]),
      ),
    );
  }
}
