import 'package:flutter/material.dart';

class CustomStoryList extends StatelessWidget {
  const CustomStoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding:  EdgeInsets.all(5),
                  child: Column(
                    children: [
                      CircleAvatar(radius: 45, backgroundColor: Colors.grey),
                      Text("User Name")
                    ],
                  ),
                );
              },
            ),
          );
  }
}