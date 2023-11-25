// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBkutrXqj32rhoAmccV8JYsmErF6s1FNYI',
    appId: '1:416381443647:web:df66078c29b2bbcfbf228a',
    messagingSenderId: '416381443647',
    projectId: 'tik-tok-clone-by-minsu',
    authDomain: 'tik-tok-clone-by-minsu.firebaseapp.com',
    storageBucket: 'tik-tok-clone-by-minsu.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoklK_rCdqImdPaR5yH63tbS627TKy9XY',
    appId: '1:416381443647:android:905e436af573252dbf228a',
    messagingSenderId: '416381443647',
    projectId: 'tik-tok-clone-by-minsu',
    storageBucket: 'tik-tok-clone-by-minsu.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwZ__X3RrpW2dVPh0xSq5CG2CtjdCfG5o',
    appId: '1:416381443647:ios:72669d9eddf4ed08bf228a',
    messagingSenderId: '416381443647',
    projectId: 'tik-tok-clone-by-minsu',
    storageBucket: 'tik-tok-clone-by-minsu.appspot.com',
    iosBundleId: 'com.example.tiktokClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAwZ__X3RrpW2dVPh0xSq5CG2CtjdCfG5o',
    appId: '1:416381443647:ios:9b7b424ad17629d3bf228a',
    messagingSenderId: '416381443647',
    projectId: 'tik-tok-clone-by-minsu',
    storageBucket: 'tik-tok-clone-by-minsu.appspot.com',
    iosBundleId: 'com.example.tiktokClone.RunnerTests',
  );
}
