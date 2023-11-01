import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/featurs/main_navigation/widgets/navigation_button.dart';

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
        Text("Search"),
      ],
    ),
    const Column(
      children: [
        Text("Home"),
      ],
    ),
    const Column(
      children: [
        Text("Search"),
      ],
    ),
  ];

  int _selectedIndex = 0;

  void _onTap(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
          ),
          child: Row(
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
