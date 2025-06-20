// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: WEB_WINDOWS_API_KEY,
    appId: '1:956835114993:web:ef7acbe2978e22e5159e50',
    messagingSenderId: '956835114993',
    projectId: 'the-nomnom-collective',
    authDomain: 'the-nomnom-collective.firebaseapp.com',
    storageBucket: 'the-nomnom-collective.firebasestorage.app',
    measurementId: 'G-Y5DCQLX25M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: ANDROID_API_KEY,
    appId: '1:956835114993:android:85581df282762a3c159e50',
    messagingSenderId: '956835114993',
    projectId: 'the-nomnom-collective',
    storageBucket: 'the-nomnom-collective.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: IOS_MACOS_API_KEY,
    appId: '1:956835114993:ios:1d26eebc4d364191159e50',
    messagingSenderId: '956835114993',
    projectId: 'the-nomnom-collective',
    storageBucket: 'the-nomnom-collective.firebasestorage.app',
    iosClientId: '956835114993-nkbfc0k1k6vinm4i462kf8cpm243k1fe.apps.googleusercontent.com',
    iosBundleId: 'com.example.theNomnomCollective',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: IOS_MACOS_API_KEY,
    appId: '1:956835114993:ios:1d26eebc4d364191159e50',
    messagingSenderId: '956835114993',
    projectId: 'the-nomnom-collective',
    storageBucket: 'the-nomnom-collective.firebasestorage.app',
    iosClientId: '956835114993-nkbfc0k1k6vinm4i462kf8cpm243k1fe.apps.googleusercontent.com',
    iosBundleId: 'com.example.theNomnomCollective',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: WEB_WINDOWS_API_KEY,
    appId: '1:956835114993:web:550bb54cb3bc0f2e159e50',
    messagingSenderId: '956835114993',
    projectId: 'the-nomnom-collective',
    authDomain: 'the-nomnom-collective.firebaseapp.com',
    storageBucket: 'the-nomnom-collective.firebasestorage.app',
    measurementId: 'G-9E9G8C6DWF',
  );

}
