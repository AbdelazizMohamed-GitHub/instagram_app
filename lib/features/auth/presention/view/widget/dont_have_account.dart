import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/app_colors.dart';
import 'package:instagram_app/core/utils/routs.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(onPressed: (){Navigator.pushNamed(context, AppRouter.registerScreenRoute);}, child: const Text("Register",
                        style: TextStyle(color: AppColors.blue, fontSize: 20)))
                  ],
                );
  }
}