import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBaSydLImFH23jxsM-S2Zv_PGe32-hHSKc',
    appId: '1:331879681184:web:551f9f40163c446a470dc5',
    messagingSenderId: '331879681184',
    projectId: 'meal-recipes-9ba53',
    authDomain: 'meal-recipes-9ba53.firebaseapp.com',
    databaseURL: 'https://meal-recipes-9ba53-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'meal-recipes-9ba53.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANBqMRVuf4Yo7TUGTXU8h-sS_SEFKDuhE',
    appId: '1:331879681184:android:6bccb32c4e413786470dc5',
    messagingSenderId: '331879681184',
    projectId: 'meal-recipes-9ba53',
    databaseURL: 'https://meal-recipes-9ba53-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'meal-recipes-9ba53.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTUhZIK9yAecMyKX8NqmxOpBDtiVIqtl0',
    appId: '1:331879681184:ios:327d79f8568ef295470dc5',
    messagingSenderId: '331879681184',
    projectId: 'meal-recipes-9ba53',
    databaseURL: 'https://meal-recipes-9ba53-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'meal-recipes-9ba53.firebasestorage.app',
    iosBundleId: 'com.example.flutterLab2222006',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDTUhZIK9yAecMyKX8NqmxOpBDtiVIqtl0',
    appId: '1:331879681184:ios:327d79f8568ef295470dc5',
    messagingSenderId: '331879681184',
    projectId: 'meal-recipes-9ba53',
    databaseURL: 'https://meal-recipes-9ba53-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'meal-recipes-9ba53.firebasestorage.app',
    iosBundleId: 'com.example.flutterLab2222006',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBaSydLImFH23jxsM-S2Zv_PGe32-hHSKc',
    appId: '1:331879681184:web:4b20c341c6693ff7470dc5',
    messagingSenderId: '331879681184',
    projectId: 'meal-recipes-9ba53',
    authDomain: 'meal-recipes-9ba53.firebaseapp.com',
    databaseURL: 'https://meal-recipes-9ba53-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'meal-recipes-9ba53.firebasestorage.app',
  );
}
