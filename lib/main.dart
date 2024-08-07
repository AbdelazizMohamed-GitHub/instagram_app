import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/routs.dart';
import 'package:instagram_app/features/auth/presention/view/login_screen.dart';
import 'package:instagram_app/features/auth/presention/view/register_screen.dart';
import 'package:instagram_app/features/onboarding/presention/view/onboardin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
      initialRoute: AppRouter.onBoardingScreenRoute,
    );
  }
}
