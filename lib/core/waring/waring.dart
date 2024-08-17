import 'dart:ffi';

import 'package:flutter/material.dart';
 

void snackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: const Duration(seconds: 10),
  ));
}

alert(context) {
  return showDialog(
    builder: (BuildContext context) {
      return const AlertDialog(
          title: Text(' برجاء الانتظار'),
          content: SizedBox(
              height: 50, child: Center(child: CircularProgressIndicator())));
    },
    context: context,
  );
}