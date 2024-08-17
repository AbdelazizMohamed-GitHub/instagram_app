import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/auth/data/repo/repo_imp.dart';
import 'package:instagram_app/features/auth/presention/cubits/register_cubit.dart/register_cubit.dart';
import 'package:instagram_app/features/auth/presention/view/widget/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterCubit(authRepo: AuthRepoImp()),
        child: const RegisterScreenBody(),
      ),
    );
  }
}
