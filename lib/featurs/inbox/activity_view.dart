import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView>
    with SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ));

  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  late final Animation<Offset> _panelAnimation = Tween(
    begin: const Offset(0, -1),
    end: const Offset(0, 0),
  ).animate(_animationController);

  final List<Map<String, dynamic>> _tabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    }
  ];

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDismissed(String notification) {
    setState(() {
      _notifications.remove(notification);
    });
  }

  void _onTitleTap() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTitleTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All activity"),
              Gaps.h2,
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(
              // horizontal: Sizes.size16,
              vertical: Sizes.size16,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                ),
                child: Text(
                  "New",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gaps.v16,
              for (final notification in _notifications)
                Dismissible(
                  onDismissed: (direction) => _onDismissed(notification),
                  key: Key(notification),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.green,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: Sizes.size16,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.checkDouble,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: Sizes.size16,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    // contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: Sizes.size52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                          text: "Account updates:",
                          style: const TextStyle(
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(
                              text: " Upload longer videos",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: " $notification",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ]),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size16,
                    ),
                  ),
                ),
            ],
          ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size8),
                  bottomRight: Radius.circular(Sizes.size8),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          FaIcon(
                            tab["icon"],
                            color: Colors.black,
                            size: Sizes.size16,
                          ),
                          Gaps.h16,
                          Text(
                            "${tab["title"]}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
