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
    apiKey: 'AIzaSyDgxs6coNZP1xGEfzxu_1ts7KM30kUQDZU',
    appId: '1:9293164990:web:206f45435a1361b65849ef',
    messagingSenderId: '9293164990',
    projectId: 'matchat-8e995',
    authDomain: 'matchat-8e995.firebaseapp.com',
    storageBucket: 'matchat-8e995.appspot.com',
    measurementId: 'G-HFJ502C79B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCU5xxgPkcqm4gI4SUcqSh0iOtp9Oh3pOw',
    appId: '1:9293164990:android:1bd8d8c00848c1c25849ef',
    messagingSenderId: '9293164990',
    projectId: 'matchat-8e995',
    storageBucket: 'matchat-8e995.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5uH3ZNDzy3vThK5vEcFrNFa1-W9KDMyU',
    appId: '1:9293164990:ios:c084cf7bf72f8d255849ef',
    messagingSenderId: '9293164990',
    projectId: 'matchat-8e995',
    storageBucket: 'matchat-8e995.appspot.com',
    iosClientId: '9293164990-s5fmaef647kd9080qog482q16eeac6t5.apps.googleusercontent.com',
    iosBundleId: 'com.dissingardjino.digitaldschool',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB5uH3ZNDzy3vThK5vEcFrNFa1-W9KDMyU',
    appId: '1:9293164990:ios:c084cf7bf72f8d255849ef',
    messagingSenderId: '9293164990',
    projectId: 'matchat-8e995',
    storageBucket: 'matchat-8e995.appspot.com',
    iosClientId: '9293164990-s5fmaef647kd9080qog482q16eeac6t5.apps.googleusercontent.com',
    iosBundleId: 'com.dissingardjino.digitaldschool',
  );
}
