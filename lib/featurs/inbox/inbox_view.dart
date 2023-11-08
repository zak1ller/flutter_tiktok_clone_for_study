import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class InboxView extends StatelessWidget {
  const InboxView({super.key});

  void _onDmTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Inbox"),
        actions: [
          IconButton(
            onPressed: _onDmTap,
            icon: const FaIcon(FontAwesomeIcons.message),
          ),
        ],
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text(
              "Activity",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
          ListTile(
            title: const Text(
              "New followers",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              "Messages from followers will appear here",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.userGroup,
                  color: Colors.white,
                ),
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
