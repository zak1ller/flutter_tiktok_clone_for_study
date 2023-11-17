import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/featurs/authentication/login_view.dart';
import 'package:tiktok_clone/featurs/authentication/sign_up_view.dart';
import 'package:tiktok_clone/featurs/onboarding/interests_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpView.routeName,
      path: SignUpView.routeURL,
      builder: (context, state) => const SignUpView(),
    ),
    GoRoute(
      name: LoginView.routeName,
      path: LoginView.routeURL,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      name: InterestsView.routeName,
      path: InterestsView.routeURL,
      builder: (context, state) => const InterestsView(),
    ),
  ],
);
