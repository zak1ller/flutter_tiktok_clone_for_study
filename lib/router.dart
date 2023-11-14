import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/featurs/authentication/email_view.dart';
import 'package:tiktok_clone/featurs/authentication/login_view.dart';
import 'package:tiktok_clone/featurs/authentication/sign_up_view.dart';
import 'package:tiktok_clone/featurs/authentication/username_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        name: SignUpView.routeName,
        path: SignUpView.routeURL,
        builder: (context, state) => const SignUpView(),
        routes: [
          GoRoute(
              name: UsernameView.routeName,
              path: UsernameView.routeURL,
              builder: (context, state) => const UsernameView(),
              routes: [
                GoRoute(
                  name: EmailView.routeName,
                  path: EmailView.routeURL,
                  builder: (context, state) {
                    final args = state.extra as EmailViewArgs;
                    return EmailView(username: args.username);
                  },
                ),
              ]),
        ]),
    GoRoute(
      path: LoginView.routeName,
      builder: (context, state) => const LoginView(),
    ),
    // GoRoute(
    //   name: "username_view",
    //   path: UsernameView.routeName,
    //   // builder: (context, state) => const UsernameView(),
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       child: const UsernameView(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: child,
    //         );
    //       },
    //     );
    //   },
    // ),

    // GoRoute(
    //   path: EmailView.routeName,
    //   builder: (context, state) {
    //     final args = state.extra as EmailViewArgs;
    //     return EmailView(username: args.username);
    //   },
    // ),
    // GoRoute(
    //   path: "/users/:username",
    //   builder: (context, state) {
    //     final username = state.pathParameters['username'];
    //     final tab = state.uri.queryParameters['show'];
    //     if (tab != null) {
    //       if (tab == "posts") {
    //         return UserProfileView(
    //           defaultPage: 0,
    //           username: username!,
    //         );
    //       } else if (tab == "likes") {
    //         return UserProfileView(
    //           defaultPage: 1,
    //           username: username!,
    //         );
    //       } else {
    //         return UserProfileView(
    //           username: username!,
    //         );
    //       }
    //     } else {
    //       return UserProfileView(
    //         username: username!,
    //       );
    //     }
    //   },
    // ),
  ],
);
