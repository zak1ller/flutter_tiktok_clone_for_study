import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/featurs/main_navigation/widgets/navigation_button.dart';
import 'package:tiktok_clone/featurs/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/featurs/videos/video_timeline_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  final List<Widget> views = [
    const Column(
      children: [
        Text("Home"),
      ],
    ),
    const Column(
      children: [
        Text("Discover"),
      ],
    ),
    const Column(
      children: [
        Text("Video"),
      ],
    ),
    const Column(
      children: [
        Text("Inbox"),
      ],
    ),
    const Column(
      children: [
        Text("Profile"),
      ],
    ),
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
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineView(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: views[_selectedIndex],
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: views[_selectedIndex],
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: views[_selectedIndex],
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: views[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
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
                onTap: () => _onTap(0),
              ),
              NavigationButton(
                icon: FontAwesomeIcons.magnifyingGlass,
                title: "Dicover",
                isSelected: _selectedIndex == 1,
                onTap: () => _onTap(1),
              ),
              NavigationButton(
                icon: Icons.abc,
                title: "custom",
                isSelected: _selectedIndex == 2,
                onTap: () => _onPostVideoTap(),
                customWidget: const PostVedioButton(),
              ),
              NavigationButton(
                icon: FontAwesomeIcons.message,
                title: "Inbox",
                isSelected: _selectedIndex == 3,
                onTap: () => _onTap(3),
              ),
              NavigationButton(
                icon: FontAwesomeIcons.user,
                title: "Profile",
                isSelected: _selectedIndex == 4,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
