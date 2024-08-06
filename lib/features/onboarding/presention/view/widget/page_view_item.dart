import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, required this.image, required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: SvgPicture.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Text(
              textAlign: TextAlign.center,
              text,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
