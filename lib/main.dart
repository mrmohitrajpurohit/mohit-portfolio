import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB8kAUSiXcSSvsSSGYPVDDkGMc_gFI7S6k",
          authDomain: "mohit-portfolio-db1ad.firebaseapp.com",
          projectId: "mohit-portfolio-db1ad",
          storageBucket: "mohit-portfolio-db1ad.firebasestorage.app",
          messagingSenderId: "822476086283",
          appId: "1:822476086283:web:0a13ae7435f3730a8c7b0e",
          measurementId: "G-76PEYYGPVC"),
    );
  } else {
    await Firebase.initializeApp(); // Mobile
  }
  runApp(const MyApp());
}
