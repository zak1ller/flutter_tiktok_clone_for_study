import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/featurs/discover/discover_view.dart';
import 'package:tiktok_clone/featurs/inbox/inbox_view.dart';
import 'package:tiktok_clone/featurs/main_navigation/widgets/navigation_button.dart';
import 'package:tiktok_clone/featurs/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/featurs/users/user_profile_view.dart';
import 'package:tiktok_clone/featurs/videos/video_timeline_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  final List<Widget> views = [
    const VideoTimelineView(),
    const DiscoverView(),
    const InboxView(),
    const InboxView(),
    const UserProfileView(),
  ];

  int _selectedIndex = 0;

  void _onTap(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  void _onPostVideoTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Container(),
        fullscreenDialog: true,
      ),
    );
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
            child: const UserProfileView(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
          ),
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
      ),
    );
  }
}
