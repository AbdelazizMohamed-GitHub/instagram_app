import 'package:flutter/material.dart';

class CustomOrDivider extends StatelessWidget {
  const CustomOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
                  children: [
                    Expanded(child: Divider(thickness: 2)),
                    Text(
                      " OR ",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    Expanded(child: Divider(thickness: 2))
                  ],
                );
  }
}