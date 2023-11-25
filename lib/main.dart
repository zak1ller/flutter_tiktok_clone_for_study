import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/featurs/notifications/notifications_provider.dart';
import 'package:tiktok_clone/featurs/videos/repositories/video_playback_config_repo.dart';
import 'package:tiktok_clone/featurs/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final preferences = await SharedPreferences.getInstance();
  final repository = VideoPlaybackConfigRepository(preferences);

  // 세로 화면 고정
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  // Status bar 색상 고정
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(
    ProviderScope(
      overrides: [
        playbackConfigProvider.overrideWith(
          () => PlaybackConfigViewModel(repository),
        )
      ],
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends ConsumerWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(notificationsProvider);
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'TikTok Clone',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: Sizes.size24,
            fontWeight: FontWeight.w700,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFE9435A),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
      ),
    );
  }
}
