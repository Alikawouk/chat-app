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
    apiKey: 'AIzaSyBUNUf5YpCFKysaO3O-4_OpFWQg-d1twQs',
    appId: '1:171080900771:web:4843e8849ebd685f18df16',
    messagingSenderId: '171080900771',
    projectId: 'chat-5e5d2',
    authDomain: 'chat-5e5d2.firebaseapp.com',
    databaseURL: 'https://chat-5e5d2-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'chat-5e5d2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVabeWQ_Wo2aM1jLI5DiMupS2geUG-VjM',
    appId: '1:171080900771:android:30c731bb83fcd05518df16',
    messagingSenderId: '171080900771',
    projectId: 'chat-5e5d2',
    databaseURL: 'https://chat-5e5d2-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'chat-5e5d2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVHkL4fC0WMl4uksxlNdsoi6N-U4FHNrc',
    appId: '1:171080900771:ios:d580aa5b34c9155b18df16',
    messagingSenderId: '171080900771',
    projectId: 'chat-5e5d2',
    databaseURL: 'https://chat-5e5d2-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'chat-5e5d2.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVHkL4fC0WMl4uksxlNdsoi6N-U4FHNrc',
    appId: '1:171080900771:ios:0ed508ec8d21896418df16',
    messagingSenderId: '171080900771',
    projectId: 'chat-5e5d2',
    databaseURL: 'https://chat-5e5d2-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'chat-5e5d2.appspot.com',
    iosBundleId: 'com.example.chat.RunnerTests',
  );
}
