import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PostVedioButton extends StatelessWidget {
  const PostVedioButton({
    super.key,
    this.reverse = false,
  });

  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 37,
            child: Container(
              width: 25,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF61D4F0),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            left: 37,
            child: Container(
              width: 25,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Container(
            width: 55,
            height: 40,
            decoration: BoxDecoration(
              color: reverse ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: reverse ? Colors.black : Colors.white,
                size: Sizes.size24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
