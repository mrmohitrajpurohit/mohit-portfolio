import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mohit_portfolio/screens/home/home_screen.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/keys.dart';
import 'main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (_, __) {
        return MaterialApp(
          navigatorKey: Keys.navigatorKey,
          title: 'Michael Carter Portfolio',
          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,

          builder: (context, child) {
            return Overlay(
              initialEntries: [
                if (child != null)
                  OverlayEntry(builder: (_) => child),
              ],
            );
          },

          scrollBehavior:
          const MaterialScrollBehavior().copyWith(dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          }),

          home: const HomeScreen(),
        );
      },
    );
  }
}
