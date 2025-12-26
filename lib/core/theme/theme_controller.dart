import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme_mode.dart';

class ThemeController extends ChangeNotifier {
  static const _storageKey = 'app_theme_mode';

  // If _savedMode is null => no user preference saved => use system theme
  AppThemeMode? _savedMode;

  AppThemeMode? get savedMode => _savedMode;

  /// Returns the active ThemeMode. If no saved preference exists, return system.
  ThemeMode get themeMode {
    if (_savedMode == null) return ThemeMode.system;
    switch (_savedMode!) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  AppThemeMode get effectiveMode {
    if (_savedMode != null) {
      return _savedMode!;
    }
    // No saved preference; determine effective mode based on system brightness
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
  }

  /// Load saved theme preference; if none found, keep _savedMode as null.
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_storageKey);

    if (value != null) {
      // Map stored value to AppThemeMode if possible, otherwise clear saved mode
      try {
        _savedMode = AppThemeMode.values.firstWhere(
          (e) => e.name == value,
        );
      } catch (_) {
        _savedMode = null;
      }
    } else {
      _savedMode = null; // explicit: no saved preference => system
    }

    // Do not call notifyListeners() here; caller (main) will rebuild after init
  }

  /// Set a theme preference. Pass `null` to clear preference and revert to system.
  Future<void> setTheme(AppThemeMode? mode) async {
    final prefs = await SharedPreferences.getInstance();

    if (mode == null) {
      _savedMode = null;
      await prefs.remove(_storageKey);
    } else {
      _savedMode = mode;
      await prefs.setString(_storageKey, mode.name);
    }

    notifyListeners();
  }
}
