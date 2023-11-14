import 'package:flutter/material.dart';
import 'package:tiktok_clone/utils/color_manager.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    required this.onTap,
    this.text = 'Next',
  });

  final String text;
  final bool disabled;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!disabled) {
          onTap.call();
        }
      },
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AnimatedContainer(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: disabled
                ? ColorManager.isDarkMode(context)
                    ? Colors.grey.shade800
                    : Colors.grey.shade400
                : Theme.of(context).primaryColor,
          ),
          duration: const Duration(
            milliseconds: 100,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 100),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: disabled ? Colors.grey.shade100 : Colors.white,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
