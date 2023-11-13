import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/featurs/discover/widgets/top_grid.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView>
    with TickerProviderStateMixin {
  final TextEditingController _textEditingController =
      TextEditingController(text: "Default");

  late TabController _tabBarController;

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
  void initState() {
    super.initState();
    _initTabBarController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabBarController.dispose();
    super.dispose();
  }

  void _initTabBarController() {
    _tabBarController = TabController(length: tabs.length, vsync: this);
    _tabBarController.addListener(() {
      FocusScope.of(context).unfocus();
    });
  }

  void _onSearchChanged(String value) {}

  void _onSearchSubmitted(String value) {}

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        title: CupertinoSearchTextField(
          controller: _textEditingController,
          onChanged: _onSearchChanged,
          onSubmitted: _onSearchSubmitted,
        ),
        bottom: TabBar(
          controller: _tabBarController,
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
      body: TabBarView(
        controller: _tabBarController,
        children: [
          GridView.builder(
            itemCount: 7,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
              vertical: Sizes.size8,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width > Breakpoints.lg ? 5 : 2,
              crossAxisSpacing: Sizes.size8,
              mainAxisSpacing: Sizes.size8,
              childAspectRatio: 9 / 20,
            ),
            itemBuilder: (context, index) => const TopGrid(),
          ),
          for (final tab in tabs.skip(1))
            Center(
              child: Text(tab),
            ),
        ],
      ),
    );
  }
}
