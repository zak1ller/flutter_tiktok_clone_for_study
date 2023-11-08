import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class DiscoverView extends StatelessWidget {
  DiscoverView({super.key});

  final tabs = [
    "Top",
    "Users",
    "Videos",
    "Sounds",
    "LIVE",
    "Shopping",
    "Brands",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text("Discover"),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
            labelStyle: const TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              for (final tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(children: [
          GridView.builder(
            itemCount: 20,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
              vertical: Sizes.size8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: Sizes.size8,
              mainAxisSpacing: Sizes.size8,
              childAspectRatio: 9 / 16,
            ),
            itemBuilder: (context, index) => Container(
              color: Colors.black,
              child: Center(
                child: Text("$index"),
              ),
            ),
          ),
          for (final tab in tabs.skip(1))
            Center(
              child: Text(tab),
            ),
        ]),
      ),
    );
  }
}
