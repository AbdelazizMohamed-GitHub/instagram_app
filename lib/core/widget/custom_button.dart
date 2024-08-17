import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/app_colors.dart';
import 'package:instagram_app/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text });
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      onPressed: onPressed,
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: AppStyles.text18Bold),
    );
  }
}
