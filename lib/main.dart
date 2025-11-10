import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB7iEvUh8FhCNXv87zhpDFDtRn2VKQthSo",
          authDomain: "my-portfolio-1f4cd.firebaseapp.com",
          projectId: "my-portfolio-1f4cd",
          storageBucket: "my-portfolio-1f4cd.firebasestorage.app",
          messagingSenderId: "261516330636",
          appId: "1:261516330636:web:a3f0e65d7166c89b18dda9",
          measurementId: "G-9QMVD7M1XF"),
    );
  } else {
    await Firebase.initializeApp(); // Mobile
  }
  runApp(const MyApp());
}
