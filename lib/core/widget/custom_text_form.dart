import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/app_colors.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm(
      {super.key,
      required this.pIcon,
      this.sIcon,
      required this.text,
      required this.textController,
      required this.obscureText,
      required this.kTybe});
  final IconData pIcon;
  final Widget? sIcon;
  final String text;
  final TextEditingController textController;
  final bool obscureText;
  final TextInputType kTybe;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: kTybe,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      controller: textController,
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffEEEEEE),
          errorBorder: border,
          focusedErrorBorder: border,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.primaryColor)),
          enabledBorder: border,
          prefixIcon: Icon(pIcon),
          suffixIcon: sIcon,
          hintText: text),
    );
  }
}

var border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
);
