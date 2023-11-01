import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class TutorialPage extends StatelessWidget {
  final String title;
  final String contents;

  const TutorialPage({
    super.key,
    required this.title,
    required this.contents,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v80,
        Text(
          title,
          style: const TextStyle(
            fontSize: Sizes.size40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v16,
        Text(
          contents,
          style: const TextStyle(
            fontSize: Sizes.size20,
          ),
        ),
      ],
    );
  }
}
