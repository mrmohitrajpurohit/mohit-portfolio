import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  final BuildContext context;
  AppTextStyles._(this.context);

  static AppTextStyles of(BuildContext context) =>
      AppTextStyles._(context);

  AppColors get _colors => AppColors.of(context);

  // ================= NAVBAR =================
  TextStyle get navTitle => GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    color: _colors.textPrimary,
  );

  TextStyle get navTitleMobile => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
    color: _colors.textPrimary,
  );

  TextStyle get navItem => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _colors.textPrimary,
  );

  TextStyle get navItemMobile => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: _colors.textPrimary,
  );

  // ================= HERO =================
  TextStyle get heroTitle => GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: _colors.heroPrimaryText,
  );

  TextStyle get heroSubtitle => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: _colors.heroSecondaryText,
  );

  // ================= PROJECTS =================
  TextStyle get projectsTitle => GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: _colors.projectsTitle,
  );

  TextStyle get projectsSubtitle => GoogleFonts.poppins(
    fontSize: 16,
    color: _colors.projectsSubtitle,
  );

  // ================= PROJECT CARD =================
  TextStyle projectCardTitle(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 18 : 22,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  TextStyle projectCardDesc(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 13 : 14,
    color: Colors.white70,
  );

  TextStyle projectTechChip(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 11 : 12,
    color: Colors.white,
  );

  // ================= AI WORK =================
  TextStyle aiSectionTitle(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 22 : 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.2,
    color: _colors.aiTitle,
  );

  TextStyle aiSectionDesc(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 14 : 16,
    height: 1.55,
    color: _colors.aiDescription,
  );

  // ================= AI CARD =================
  TextStyle aiCardTitle(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 16 : 18,
    fontWeight: FontWeight.w700,
    color: _colors.aiCardTitle,
  );

  TextStyle aiCardDesc(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 13 : 14,
    height: 1.4,
    color: _colors.aiCardDesc,
  );

  TextStyle aiChipText(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 11 : 12,
    color: Colors.white,
  );

  // ================= CERTIFICATIONS =================
  TextStyle certSectionTitle(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 22 : 30,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.3,
    color: _colors.certTitle,
  );

  TextStyle certSectionDesc(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 14 : 16,
    height: 1.6,
    color: _colors.certSubtitle,
  );

  // ================= CERTIFICATE CARD =================
  TextStyle certCardTitle(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 15 : 17,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  TextStyle certCardSubtitle(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 13 : 14,
    color: Colors.white70,
  );

  // ================= SKILLS =================
  TextStyle skillsSectionTitle(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 24 : 34,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.4,
    color: _colors.skillsTitle,
  );

  TextStyle skillsSectionDesc(bool isMobile) => GoogleFonts.poppins(
    fontSize: isMobile ? 14 : 17,
    height: 1.6,
    color: _colors.skillsSubtitle,
  );

  // ================= SKILL CARD =================
  TextStyle skillCategoryTitle() => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  TextStyle skillName() => GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  TextStyle skillPercent() => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    color: _colors.skillPercentText,
  );
}
