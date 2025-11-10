import 'dart:io' show Platform;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static const String appTitle = 'My Flutter App';
  static const int maxUsers = 100;
  static const double pi = 3.14159;
  static const Color primaryColor = Colors.blue;

  static bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static bool isMobileView(BuildContext context) =>
      MediaQuery.of(context).size.width <= 1024;

  /// Returns true if the screen width is considered tablet (responsive check)
  static bool isTabletView(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }

  /// Returns true if the screen width is considered desktop (responsive check)
  static bool isDesktopView(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  // Correct way to get screenWidth as a "getter" that requires context
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getTitleFontSize(double width) {
    if (width < 400) return 16;
    if (width < 600) return 18;
    return 18;
  }

  static double getPageNameFontSize(double width) {
    if (width < 400) return 20;
    if (width < 600) return 25;
    return 30;
  }

  static double getServiceCardIconSize(double width) {
    if (width < 400) return 20;
    if (width < 600) return 22;
    return 22;
  }

  static double getDescriptionFontSize(double width) {
    if (width < 350) return 8;
    if (width < 400) return 10;
    if (width < 600) return 12;
    return 14;
  }

  static double getInfoFontSize(double width) {
    if (width < 400) return 30;
    return 40;
  }

  static double getTagFontSize(double width) {
    if (width < 400) return 10;
    return 12;
  }

  static double getImageSize(double width) {
    if (width < 400) return 80;
    if (width < 600) return 80;
    return 150;
  }

  static double getCardWidth(double width) {
    if (width < 400) return width * 0.9;
    if (width < 800) return 380;
    return 400;
  }

  static double getCardHeight(double width) {
    if (width < 400) return 320;
    if (width < 800) return 350;
    return 350;
  }

  static double getWorkCardHeight(double width) {
    if (width < 400) return 300;
    if (width < 800) return 300;
    return 200;
  }

  static double getWorkCardWidth(double width) {
    if (width < 400) return 300;
    if (width < 800) return 300;
    return 200;
  }

  static double getDevicePadding(double width) {
    if (width < 400) return 40;
    if (width < 800) return 40;
    return width * 0.2;
  }

  static double getPadding(double width) {
    if (width < 400) return 12;
    return 20;
  }

  static double getSpacing(double width) {
    if (width < 400) return 5;
    return 5;
  }
}
