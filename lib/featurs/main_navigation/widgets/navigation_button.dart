import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

// ignore: must_be_immutable
class NavigationButton extends StatelessWidget {
  final IconData icon;
  final IconData? selectedIcon;
  final String title;
  final bool isSelected;
  final bool reverse;

  final Function onTap;

  Widget? customWidget;

  NavigationButton({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.selectedIcon,
    this.customWidget,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap.call(),
        child: Container(
          decoration:
              BoxDecoration(color: reverse ? Colors.black : Colors.white),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Offstage(
                offstage: customWidget != null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: AnimatedOpacity(
                    opacity: isSelected ? 1 : 0.5,
                    duration: const Duration(milliseconds: 100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          isSelected ? selectedIcon ?? icon : icon,
                          size: Sizes.size20,
                          color: reverse ? Colors.white : Colors.black,
                        ),
                        Gaps.v8,
                        Text(
                          title,
                          style: TextStyle(
                              color: reverse ? Colors.white : Colors.black,
                              fontSize: Sizes.size14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: customWidget == null,
                child: customWidget,
              )
            ],
          ),
        ),
      ),
    );
  }
}
