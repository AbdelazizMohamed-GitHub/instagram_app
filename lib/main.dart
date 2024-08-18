import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/routs.dart';
import 'package:instagram_app/features/auth/presention/view/login_screen.dart';
import 'package:instagram_app/features/auth/presention/view/register_screen.dart';
import 'package:instagram_app/features/home/presention/view/main_screen.dart';
import 'package:instagram_app/features/onboarding/presention/view/onboardin_screen.dart';
import 'package:instagram_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();

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
        '/main': (context) => const MainScreen(),
      },
      
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? AppRouter.loginScreenRoute
          : AppRouter.mainScreenRoute,
    );
  }
}
