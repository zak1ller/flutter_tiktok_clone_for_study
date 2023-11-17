import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/main_navigation_view.dart';
import 'package:tiktok_clone/featurs/onboarding/widgets/tutorial_page.dart';
import 'package:tiktok_clone/utils/color_manager.dart';

enum Direction { left, right }

enum Page { first, second }

class TutorialView extends StatefulWidget {
  const TutorialView({super.key});

  @override
  State<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  Direction _direction = Direction.right;
  Page _page = Page.first;

  void _onPanUpdate(DragUpdateDetails detail) {
    if (detail.delta.dx > 0) {
      _direction = Direction.right;
    } else {
      _direction = Direction.left;
    }
  }

  void _onPanEnd(DragEndDetails detail) {
    if (_direction == Direction.left) {
      _page = Page.second;
    } else {
      _page = Page.first;
    }
    setState(() {});
  }

  void _onEnterAppTap() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainNavigationView(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: SafeArea(
          child: AnimatedCrossFade(
            firstChild: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size24,
              ),
              child: TutorialPage(
                title: 'Watch cool videos!',
                contents:
                    'Videos are personalized for you based on what you watch, like, and share.',
              ),
            ),
            secondChild: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size24,
              ),
              child: TutorialPage(
                title: 'Follow the rules',
                contents: 'Take care of one another! Plis!',
              ),
            ),
            crossFadeState: _page == Page.first
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: ColorManager.isDarkMode(context) ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size24,
              vertical: Sizes.size24,
            ),
            child: AnimatedOpacity(
              duration: const Duration(
                milliseconds: 300,
              ),
              opacity: _page == Page.first ? 0 : 1,
              child: CupertinoButton(
                color: Theme.of(context).primaryColor,
                onPressed: _onEnterAppTap,
                child: const Text("Enter the app!"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
