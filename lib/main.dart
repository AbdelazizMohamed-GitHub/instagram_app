import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/utils/funcation.dart';
import 'package:instagram_app/core/utils/routs.dart';
import 'package:instagram_app/features/auth/presention/view/login_screen.dart';
import 'package:instagram_app/features/auth/presention/view/register_screen.dart';
import 'package:instagram_app/features/home/data/repo_impl/post_repo_impl.dart';
import 'package:instagram_app/features/home/presention/cubits/post_cubit/post_cubit.dart';
import 'package:instagram_app/features/home/presention/view/main_screen.dart';
import 'package:instagram_app/features/onboarding/presention/view/onboardin_screen.dart';
import 'package:instagram_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();
  setupLocator();

  runApp(const Instagram());
}

class Instagram extends StatefulWidget {
  const Instagram({super.key});

  @override
  State<Instagram> createState() => _ImstagramState();
}

class _ImstagramState extends State<Instagram> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await checkLoginStatus();
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(postRepo: getIt.get<PostRepoImpl>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/main': (context) => const MainScreen(),
        },
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? _isLoggedIn
                ? AppRouter.loginScreenRoute
                : AppRouter.onBoardingScreenRoute
            : AppRouter.mainScreenRoute,
      ),
    );
  }
}
