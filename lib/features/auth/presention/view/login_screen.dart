
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/auth/data/repImplemition/repo_imp.dart';
import 'package:instagram_app/features/auth/presention/view/widget/login_screen_body.dart';

import '../cubits/login_cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(authRepo: AuthRepoImp()),
        child: const LoginScreenBody(),
      ),
    );
  }
}
