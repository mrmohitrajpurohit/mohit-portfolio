import 'package:flutter/material.dart';

class AppColors {
  final BuildContext context;
  AppColors._(this.context);

  static AppColors of(BuildContext context) => AppColors._(context);

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  // =====================================================
  // CORE PALETTE (THEME-AWARE)
  // =====================================================

  Color get primary =>
      isDark ? const Color(0xFF101010) : const Color(0xFFF7F7F7);

  Color get primaryVariant => const Color(0xFFF7F7F7);

  Color get secondary =>
      isDark ? const Color(0xFF212121) : const Color(0xFFD1D3D6);

  Color get white =>
      isDark ? const Color(0xFF101010) : const Color(0xFFFFFFFF);

  Color get black =>
      isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);

  Color get greyBlack =>
      isDark ? const Color(0xFF1F1F1F) : const Color(0xFF303030);

  Color get grey =>
      isDark ? const Color(0xFF9AA0A6) : const Color(0xFF6C7179);

  Color get lightGrey =>
      isDark ? const Color(0xFFB0B0B0) : const Color(0xFF888888);

  Color get darkGrey =>
      isDark ? const Color(0xFF303030) : const Color(0xFF1F1F1F);

  Color get accent =>
      isDark ? const Color(0xFFFFE066) : const Color(0xFFEFCE05);

  Color get lightAccent =>
      isDark ? const Color(0xFF3A3A00) : const Color(0xFFFEFEE8);

  Color get danger =>
      const Color(0xFFE74C3C); // universal (good contrast both themes)

  Color get hoverButtonBg =>
      isDark ? const Color(0xFF9A6BFF) : const Color(0xFF7430F7);

  // ================= BACKGROUNDS =================
  Color get navbarBackground =>
      isDark ? Colors.black.withOpacity(0.88) : Colors.white.withOpacity(0.88);

  Color get scaffoldBackground =>
      Theme.of(context).scaffoldBackgroundColor;

  // ================= TEXT =================
  Color get textPrimary =>
      isDark ? Colors.white : Colors.black;

  Color get textSecondary =>
      isDark ? Colors.white70 : Colors.black87;

  // ================= BORDERS =================
  Color get navbarBorder =>
      isDark ? Colors.white24 : Colors.black;

  Color get divider =>
      isDark ? Colors.white12 : Colors.grey.shade300;

  // ================= SHADOWS =================
  List<BoxShadow> get navbarShadow => isDark
      ? const [
    BoxShadow(
      color: Colors.white12,
      blurRadius: 12,
      offset: Offset(0, 3),
    ),
  ]
      : const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 12,
      offset: Offset(0, 3),
    ),
  ];

  // ================= HERO =================
  Color get heroGradientBase =>
      isDark ? const Color(0xFF121212) : const Color(0xFFF7F7F7);

  Color get heroPrimaryText =>
      isDark ? Colors.white : Colors.black;

  Color get heroSecondaryText =>
      isDark ? Colors.white70 : Colors.black87;

  // ================= PROJECTS SECTION =================
  Color get projectsSectionBackground =>
      isDark ? const Color(0xFF0F0F0F) : Colors.white;

  Color get projectsTitle =>
      isDark ? Colors.white : Colors.black;

  Color get projectsSubtitle =>
      isDark ? Colors.white70 : Colors.black87;

  // ================= PROJECT CARD =================
  Color get projectCardBorder =>
      isDark ? Colors.white12 : Colors.grey.shade300;

  Color get projectCardShadow =>
      isDark
          ? Colors.black.withOpacity(0.4)
          : Colors.black.withOpacity(0.06);

  Color get projectImagePlaceholder =>
      isDark ? Colors.white10 : Colors.grey.shade200;

  // Overlay stays dark by design
  List<Color> get projectOverlayGradient => [
    Colors.black.withOpacity(0.55),
    Colors.black.withOpacity(0.25),
    Colors.black.withOpacity(0.6),
  ];

  // ================= AI WORK SECTION =================
  Color get aiSectionBackground =>
      isDark ? const Color(0xFF111111) : Colors.grey.shade50;

  Color get aiTitle =>
      isDark ? Colors.white : Colors.black;

  Color get aiDescription =>
      isDark ? Colors.white70 : Colors.black.withOpacity(0.80);

  // ================= AI CARD =================
  Color get aiCardOverlay =>
      Colors.black.withOpacity(0.55);

  Color get aiCardTitle =>
      Colors.white;

  Color get aiCardDesc =>
      Colors.white.withOpacity(0.9);

  Color get aiChipBackground =>
      Colors.black;

  Color get aiChipBorder =>
      Colors.white.withOpacity(0.25);

  Color get aiIconPlaceholder =>
      Colors.white24;

  // ================= CERTIFICATIONS SECTION =================
  Color get certSectionBackground =>
      isDark ? const Color(0xFF0E0E0E) : Colors.white;

  Color get certTitle =>
      isDark ? Colors.white : Colors.black;

  Color get certSubtitle =>
      isDark ? Colors.white70 : Colors.black87;

  // ================= CERTIFICATE CARD =================
  Color get certCardShadow =>
      isDark
          ? Colors.black.withOpacity(0.45)
          : Colors.black.withOpacity(0.08);

  Color get certImageOverlay =>
      Colors.black.withOpacity(0.25);

  Color get certBlurOverlay =>
      Colors.black.withOpacity(0.12);

  Color get certFallbackStart =>
      isDark ? Colors.grey.shade800 : Colors.grey.shade300;

  Color get certFallbackEnd =>
      isDark ? Colors.grey.shade700 : Colors.grey.shade100;

  // ================= PREVIEW DIALOG =================
  Color get certDialogBackdrop =>
      Colors.black.withOpacity(0.6);

  Color get certDialogBackground =>
      isDark ? const Color(0xFF1A1A1A) : Colors.white;

  // ================= SKILLS SECTION =================
  Color get skillsSectionBackground =>
      isDark ? const Color(0xFF0B0B0B) : Colors.transparent;

  Color get skillsTitle =>
      isDark ? Colors.white : Colors.black;

  Color get skillsSubtitle =>
      isDark ? Colors.white70 : Colors.black87;

  // ================= SKILL CARD =================
  Color get skillCardBorder =>
      Colors.white.withOpacity(0.18);

  List<Color> get skillCardBaseGradient => const [
    Color(0xFF0F172A),
    Color(0xFF020617),
  ];

  List<Color> get skillCardOverlayGradient => [
    Colors.white.withOpacity(0.12),
    Colors.white.withOpacity(0.04),
  ];

  // ================= SKILL PROGRESS =================
  Color get skillProgressBackground =>
      Colors.white.withOpacity(0.15);

  List<Color> get skillProgressGradient => const [
    Color(0xFF38BDF8),
    Color(0xFFA855F7),
  ];

  Color get skillPercentText =>
      Colors.white70;

  // ================= CONTACT FORM =================

  /// Background gradient for contact card
  List<Color> get contactCardGradient => isDark
      ? const [
    Color(0xFF101010),
    Color(0xFF212121),
    Color(0xFF525252),
    Color(0xFFb4b4b4),
  ]
      : const [
    Color(0xFFb4b4b4),
    Color(0xFF525252),
    Color(0xFF212121),
    Color(0xFF101010),
  ];

  /// TextField background
  Color get contactFieldBackground =>
      isDark ? const Color(0xFF1E1E1E) : Colors.white;

  /// TextField border
  Color get contactFieldBorder =>
      isDark ? Colors.white24 : Colors.black26;

  /// Label & input text color
  Color get contactFieldText =>
      isDark ? Colors.white : Colors.black;

  Color get contactHintText =>
      isDark ? Colors.white54 : Colors.black54;

  /// Submit button gradient
  List<Color> get contactButtonGradient => isDark
      ? const [
    Colors.white54,
    Colors.black54,
  ]
      : const [
    Colors.black54,
    Colors.white54,
  ];

  Color get contactButtonText =>
      isDark ? Colors.black : Colors.white;
}
