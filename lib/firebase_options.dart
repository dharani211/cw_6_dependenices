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
    apiKey: 'AIzaSyAZMQDic1ZVQ9fLHbd4iS0JyvM0meHxnNc',
    appId: '1:204693285797:web:c40026a880c31f6583164c',
    messagingSenderId: '204693285797',
    projectId: 'classwork06-1895f',
    authDomain: 'classwork06-1895f.firebaseapp.com',
    storageBucket: 'classwork06-1895f.firebasestorage.app',
    measurementId: 'G-221NE7E98Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtw4vgJje3be9D3nwgKHuyhSr41rmTr-s',
    appId: '1:204693285797:android:e06b34faf26d6ee983164c',
    messagingSenderId: '204693285797',
    projectId: 'classwork06-1895f',
    storageBucket: 'classwork06-1895f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlDre87KIhI4H4a86R-ktVqEhIGuEIjUo',
    appId: '1:204693285797:ios:86be820d35548cdf83164c',
    messagingSenderId: '204693285797',
    projectId: 'classwork06-1895f',
    storageBucket: 'classwork06-1895f.firebasestorage.app',
    iosBundleId: 'com.example.cw6',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBlDre87KIhI4H4a86R-ktVqEhIGuEIjUo',
    appId: '1:204693285797:ios:86be820d35548cdf83164c',
    messagingSenderId: '204693285797',
    projectId: 'classwork06-1895f',
    storageBucket: 'classwork06-1895f.firebasestorage.app',
    iosBundleId: 'com.example.cw6',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAZMQDic1ZVQ9fLHbd4iS0JyvM0meHxnNc',
    appId: '1:204693285797:web:3917534aaa8cecbf83164c',
    messagingSenderId: '204693285797',
    projectId: 'classwork06-1895f',
    authDomain: 'classwork06-1895f.firebaseapp.com',
    storageBucket: 'classwork06-1895f.firebasestorage.app',
    measurementId: 'G-L9D1MXPW2Z',
  );

}