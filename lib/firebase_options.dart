// GENERATED FILE — SAFE TO COMMIT
// Firebase client configuration for Flutter Web

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are only configured for Web.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyB8kAUSiXcSSvsSSGYPVDDkGMc_gFI7S6k",
    authDomain: "mohit-portfolio-db1ad.firebaseapp.com",
    projectId: "mohit-portfolio-db1ad",
    storageBucket: "mohit-portfolio-db1ad.firebasestorage.app",
    messagingSenderId: "822476086283",
    appId: "1:822476086283:web:0a13ae7435f3730a8c7b0e",
    measurementId: "G-76PEYYGPVC",
  );
}
