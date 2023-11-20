import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation_view.dart';
import 'package:tiktok_clone/featurs/authentication/login_view.dart';
import 'package:tiktok_clone/featurs/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/featurs/authentication/sign_up_view.dart';
import 'package:tiktok_clone/featurs/inbox/activity_view.dart';
import 'package:tiktok_clone/featurs/inbox/chat_detail_view.dart';
import 'package:tiktok_clone/featurs/inbox/chats_view.dart';
import 'package:tiktok_clone/featurs/onboarding/interests_view.dart';
import 'package:tiktok_clone/featurs/videos/views/video_recording.dart';

final routerProvider = Provider((ref) {
  ref.read(authRepo);
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != SignUpView.routeURL &&
            state.matchedLocation != LoginView.routeURL) {
          return SignUpView.routeURL;
        }
      }
      return null;
    },
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
      GoRoute(
        path: "/:tab(home|discover|inbox|profile)",
        name: MainNavigationView.routeName,
        builder: (context, state) {
          final tab = state.pathParameters["tab"]!;
          return MainNavigationView(tab: tab);
        },
      ),
      GoRoute(
        name: ActivityView.routeName,
        path: ActivityView.routeURL,
        builder: (context, state) => const ActivityView(),
      ),
      GoRoute(
        name: ChatsView.routeName,
        path: ChatsView.routeURL,
        builder: (context, state) => const ChatsView(),
        routes: [
          GoRoute(
            name: ChatDetailView.routeName,
            path: ChatDetailView.routeURL,
            builder: (context, state) {
              final chatId = state.pathParameters["chatId"]!;
              return ChatDetailView(chatId: chatId);
            },
          )
        ],
      ),
      GoRoute(
        name: VideoRecording.routeName,
        path: VideoRecording.routeURL,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 200),
          child: const VideoRecording(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final position = Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(
              position: position,
              child: child,
            );
          },
        ),
      ),
    ],
  );
});
