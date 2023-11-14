import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/featurs/authentication/email_view.dart';
import 'package:tiktok_clone/featurs/authentication/login_view.dart';
import 'package:tiktok_clone/featurs/authentication/sign_up_view.dart';
import 'package:tiktok_clone/featurs/authentication/username_view.dart';
import 'package:tiktok_clone/featurs/users/user_profile_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const SignUpView(),
    ),
    GoRoute(
      path: LoginView.routeName,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: UsernameView.routeName,
      builder: (context, state) => const UsernameView(),
    ),
    GoRoute(
      path: EmailView.routeName,
      builder: (context, state) {
        final args = state.extra as EmailViewArgs;
        return EmailView(username: args.username);
      },
    ),
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.pathParameters['username'];
        final tab = state.uri.queryParameters['show'];
        if (tab != null) {
          if (tab == "posts") {
            return UserProfileView(
              defaultPage: 0,
              username: username!,
            );
          } else if (tab == "likes") {
            return UserProfileView(
              defaultPage: 1,
              username: username!,
            );
          } else {
            return UserProfileView(
              username: username!,
            );
          }
        } else {
          return UserProfileView(
            username: username!,
          );
        }
      },
    ),
  ],
);
