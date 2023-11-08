import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class TopGrid extends StatelessWidget {
  const TopGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 9 / 16,
          child: Image.network(
            "https://source.unsplash.com/random",
            fit: BoxFit.cover,
          ),
        ),
        Gaps.v8,
        const Text(
          "ashdjksahd jdhsakj daslkjndlk dksamdnlksaj lksajdksla dashjk asdhjkdh dsahjkdh sadhjkdhk",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size16 + Sizes.size2,
          ),
        ),
        Gaps.v8,
        Row(
          children: [
            const CircleAvatar(
              radius: Sizes.size16,
              backgroundImage:
                  NetworkImage("https://source.unsplash.com/random"),
            ),
            Gaps.h4,
            Expanded(
              child: Text(
                "Jason asdjkl dsadj jkl dsajkl jdsa a djkl dsajkl dsjakld djsakl",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Gaps.h4,
            FaIcon(
              FontAwesomeIcons.heart,
              size: Sizes.size14,
              color: Colors.grey.shade600,
            ),
            Gaps.h2,
            Text(
              "2.5M",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}