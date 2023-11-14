import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/featurs/settings/settings_view.dart';
import 'package:tiktok_clone/featurs/users/widget/persistent_tab_bar.dart';
import 'package:tiktok_clone/featurs/users/widget/user_profile_grid.dart';
import 'package:tiktok_clone/featurs/users/widget/user_profile_info.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({
    super.key,
    required this.username,
    this.defaultPage = 0,
  });

  final String username;
  final int defaultPage;

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  void _onSettingsTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: widget.defaultPage,
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text("Profile"),
                actions: [
                  IconButton(
                    onPressed: _onSettingsTap,
                    icon: const FaIcon(
                      FontAwesomeIcons.gear,
                      size: Sizes.size20,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      foregroundImage: NetworkImage(
                        "https://source.unsplash.com/random",
                      ),
                      child: Text("Jason"),
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "@${widget.username}",
                          style: const TextStyle(
                            fontSize: Sizes.size16 + Sizes.size2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gaps.h4,
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          size: Sizes.size16,
                          color: Colors.blue.shade500,
                        ),
                      ],
                    ),
                    Gaps.v24,
                    SizedBox(
                      height: Sizes.size48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const UserProfileInfo(
                            value: '97',
                            title: "Following",
                          ),
                          VerticalDivider(
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade500,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),
                          const UserProfileInfo(
                            value: '10M',
                            title: "Followers",
                          ),
                          VerticalDivider(
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade500,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),
                          const UserProfileInfo(
                            value: '194.3M',
                            title: "Likes",
                          ),
                        ],
                      ),
                    ),
                    Gaps.v14,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size12,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(Sizes.size4),
                        ),
                      ),
                      child: const FractionallySizedBox(
                        widthFactor: 0.33,
                        child: Text(
                          "Follow",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Gaps.v14,
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.size32,
                      ),
                      child: Text(
                        "All highlights and where to watch live matches on FIFA+",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v14,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.link,
                          size: Sizes.size12,
                        ),
                        Gaps.h4,
                        Text(
                          "https://nomardcoders.co",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v20,
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistentTabBar(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                itemCount: 7,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: Sizes.size2,
                  mainAxisSpacing: Sizes.size2,
                  childAspectRatio: 9 / 14,
                ),
                itemBuilder: (context, index) => const UserProfileGrid(),
              ),
              const Center(
                child: Text("Page two"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
