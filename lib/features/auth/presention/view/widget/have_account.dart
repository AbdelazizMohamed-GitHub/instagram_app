import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/app_colors.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Have an account? ",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Login",
                style: TextStyle(color: AppColors.primaryColor, fontSize: 20)))
      ],
    );
  }
}
