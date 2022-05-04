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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDQ_oXD09JUFGDsayGL-SQOvgcVU_ZUDUU',
    appId: '1:314214328555:web:9c0a52cd246cd6c562f6ae',
    messagingSenderId: '314214328555',
    projectId: 'terrains-game',
    authDomain: 'terrains-game.firebaseapp.com',
    databaseURL: 'https://terrains-game-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'terrains-game.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdVLseFPRvsxYAbajc9ydopnY6tVlEiUk',
    appId: '1:314214328555:android:4137b7253b97abc262f6ae',
    messagingSenderId: '314214328555',
    projectId: 'terrains-game',
    databaseURL: 'https://terrains-game-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'terrains-game.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAx892T4fsHvxBSmYW2YnOQ02mWw7cTX8M',
    appId: '1:314214328555:ios:ebb700332ebb36a962f6ae',
    messagingSenderId: '314214328555',
    projectId: 'terrains-game',
    databaseURL: 'https://terrains-game-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'terrains-game.appspot.com',
    iosClientId: '314214328555-atc54gr7b133m1l5345guoc7ls6nemm7.apps.googleusercontent.com',
    iosBundleId: 'tech.bam.terrains',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAx892T4fsHvxBSmYW2YnOQ02mWw7cTX8M',
    appId: '1:314214328555:ios:ebb700332ebb36a962f6ae',
    messagingSenderId: '314214328555',
    projectId: 'terrains-game',
    databaseURL: 'https://terrains-game-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'terrains-game.appspot.com',
    iosClientId: '314214328555-atc54gr7b133m1l5345guoc7ls6nemm7.apps.googleusercontent.com',
    iosBundleId: 'tech.bam.terrains',
  );
}