import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/featurs/authentication/login_view.dart';
import 'package:tiktok_clone/featurs/authentication/username_view.dart';
import 'package:tiktok_clone/featurs/authentication/view_models/social_auth_view_mode.dart';
import 'package:tiktok_clone/featurs/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/utils/color_manager.dart';

class SignUpView extends ConsumerWidget {
  const SignUpView({super.key});

  static const routeURL = "/";
  static const routeName = "signUp";

  void _onLoginTap(BuildContext context) {
    context.pushNamed(LoginView.routeName);
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameView(),
      ),
    );
  }

  void _onAppleLoginTap(BuildContext context) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  const Text(
                    "Sign up for TikTok",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Text(
                    "Create a profile, follow other accounts, make your own videos, and more.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: ColorManager.isDarkMode(context)
                          ? Colors.grey.shade300
                          : Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.user),
                      text: "Use email & password",
                      onTap: () => _onEmailLoginTap(context),
                    ),
                    Gaps.v16,
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.github),
                      text: "Continue with Github",
                      onTap: () =>
                          ref.read(socialAuthProvider.notifier).githubSignIn(context),
                    ),
                  ],
                  if (orientation == Orientation.landscape) ...[
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.user),
                            text: "Use email & password",
                            onTap: () => _onEmailLoginTap(context),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.github),
                            text: "Continue with Github",
                            onTap: () => ref
                                .read(socialAuthProvider.notifier)
                                .githubSignIn(context),
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: ColorManager.isDarkMode(context)
                ? Colors.grey.shade900
                : Colors.grey.shade50,
            elevation: 2,
            height: Sizes.size60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
