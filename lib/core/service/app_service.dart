import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/routs.dart';

class AuthService {

  static Future<void> signOut(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, AppRouter.loginScreenRoute);

   
  }

}
