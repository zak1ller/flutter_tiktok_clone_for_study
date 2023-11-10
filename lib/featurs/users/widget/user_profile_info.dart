import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({
    super.key,
    required this.value,
    required this.title,
  });

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v2,
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade500),
        ),
      ],
    );
  }
}
