import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/featurs/discover/discover_view.dart';
import 'package:tiktok_clone/featurs/inbox/inbox_view.dart';
import 'package:tiktok_clone/featurs/main_navigation/widgets/navigation_button.dart';
import 'package:tiktok_clone/featurs/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/featurs/users/user_profile_view.dart';
import 'package:tiktok_clone/featurs/videos/views/video_recording.dart';
import 'package:tiktok_clone/featurs/videos/views/video_timeline_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({
    super.key,
    required this.tab,
  });

  static const String routeName = "mainNavigation";

  final String tab;

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  final List<String> _tabs = [
    "home",
    "discover",
    "xxxx",
    "inbox",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int i) {
    context.go("/${_tabs[i]}");
    setState(() {
      _selectedIndex = i;
    });
  }

  void _onPostVideoTap() {
    context.pushNamed(VideoRecording.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineView(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverView(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const InboxView(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxView(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileView(
              username: "Minsu",
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        elevation: 0,
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavigationButton(
              icon: FontAwesomeIcons.house,
              title: "Home",
              isSelected: _selectedIndex == 0,
              reverse: _selectedIndex == 0,
              onTap: () => _onTap(0),
            ),
            NavigationButton(
              icon: FontAwesomeIcons.magnifyingGlass,
              title: "Dicover",
              isSelected: _selectedIndex == 1,
              reverse: _selectedIndex == 0,
              onTap: () => _onTap(1),
            ),
            NavigationButton(
              icon: Icons.abc,
              title: "custom",
              isSelected: _selectedIndex == 2,
              reverse: _selectedIndex == 0,
              onTap: () => _onPostVideoTap(),
              customWidget: PostVedioButton(
                reverse: _selectedIndex == 0,
              ),
            ),
            NavigationButton(
              icon: FontAwesomeIcons.message,
              title: "Inbox",
              isSelected: _selectedIndex == 3,
              reverse: _selectedIndex == 0,
              onTap: () => _onTap(3),
            ),
            NavigationButton(
              icon: FontAwesomeIcons.user,
              title: "Profile",
              isSelected: _selectedIndex == 4,
              reverse: _selectedIndex == 0,
              onTap: () => _onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}
