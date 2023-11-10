import 'package:flutter/material.dart';

class UserProfileGrid extends StatelessWidget {
  const UserProfileGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 9 / 14,
          child: Image.network(
            "https://source.unsplash.com/random",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
