import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/featurs/videos/video_recording.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const VideoRecording(),
    ),
  ],
);
