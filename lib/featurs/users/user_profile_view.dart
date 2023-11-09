import 'package:flutter/material.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text("Profile"),
        ),
        SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(child: Text("Item $index")),
              ),
            ),
            itemExtent: 100),
      ],
    );
  }
}
