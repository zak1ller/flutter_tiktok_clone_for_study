import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: views[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.house),
            label: "Home",
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
          ),
        ],
      ),
    );
  }
}
