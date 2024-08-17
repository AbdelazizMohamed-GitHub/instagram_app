import 'package:flutter/material.dart';

class CustomProfileTopInformation extends StatelessWidget {
  const CustomProfileTopInformation({super.key, required this.number, required this.text});
final String number ;
final String text ;
  @override
  Widget build(BuildContext context) {
    return  Column(
                children: [
                  Text(
                    number,
                    style:const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(text)
                ],
              );
  }
}