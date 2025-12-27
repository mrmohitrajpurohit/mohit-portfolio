import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../main.dart';
import '../constants/app_constants.dart';
import '../services/remote_config_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme_mode.dart';

final config = RemoteConfigService.instance.buildConfig;

class FooterSection extends StatelessWidget {
  final bool isSticky;

  const FooterSection({super.key, this.isSticky = false});

  void _open(String url) async {
    await launchUrlString(url, webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    final colors = AppColors.of(context);
    final textStyles = AppTextStyles.of(context);

    return Container(
      height: isSticky ? (isMobile ? 60 : 72) : null,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 10 : 14,
      ),
      decoration: BoxDecoration(
        color: colors.certSectionBackground,
        border: Border(
          top: BorderSide(color: colors.projectCardBorder),
        ),
        boxShadow: isSticky
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ================= MAIN CONTENT =================
          isMobile
              ? _mobileLayout(context)
              : _desktopLayout(context),

          // ================= COPYRIGHT =================
          if (!isSticky) ...[
            const SizedBox(height: 10),
            Text(
              "© ${DateTime.now().year} Mohit • Built with Flutter Web",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: colors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ================= DESKTOP LAYOUT =================
  Widget _desktopLayout(BuildContext context) {
    final colors = AppColors.of(context);
    final textStyles = AppTextStyles.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // LEFT
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mohit",
              style: textStyles.navTitleMobile,
            ),
            Text(
              "Software Developer",
              style: textStyles.certSectionDesc(true),
            ),
          ],
        ),

        // CENTER
        Row(
          children: [
            _socialIcon(
              context,
              iconPath:
              '${AppConstants().configConstants.imageBaseUrl}assets/icons/github_icon.png',
              onTap: () => _open('https://github.com/mohit-01-code'),
            ),
            _socialIcon(
              context,
              iconPath:
              '${AppConstants().configConstants.imageBaseUrl}assets/icons/linkdin_icon.png',
              onTap: () => _open(
                'https://www.linkedin.com/in/mohit-rajpurohit-8b9ba41a3/',
              ),
            ),
            _socialIcon(
              context,
              iconPath:
              'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
              onTap: () =>
                  _open('https://www.instagram.com/_mohit_rajguru/'),
            ),
          ],
        ),

        // RIGHT
        Column(
          children: [
            TextButton.icon(
              onPressed: () => _open(
                'https://raw.githubusercontent.com/mrmohitrajpurohit/mohit-portfolio/main/Mohit-Resume.pdf',
              ),
              icon: Icon(Icons.download, size: 16, color: colors.textPrimary),
              label: Text(
                "Resume",
                style: textStyles.navItemMobile,
              ),
            ),
            ThemeToggleSwitch(colors: colors)
          ],
        ),
      ],
    );
  }

  // ================= MOBILE LAYOUT =================
  Widget _mobileLayout(BuildContext context) {
    final colors = AppColors.of(context);
    final textStyles = AppTextStyles.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Mohit", style: textStyles.navTitleMobile),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 2,
              children: [
                IconButton(
                  icon: Icon(Icons.download, color: colors.textPrimary),
                  onPressed: () => _open(
                    'https://raw.githubusercontent.com/mrmohitrajpurohit/mohit-portfolio/main/Mohit-Resume.pdf',
                  ),
                ),
                ThemeToggleSwitch(colors: colors)
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialIcon(
              context,
              iconPath:
              '${AppConstants().configConstants.imageBaseUrl}assets/icons/github_icon.png',
              onTap: () => _open('https://github.com/mohit-01-code'),
            ),
            _socialIcon(
              context,
              iconPath:
              '${AppConstants().configConstants.imageBaseUrl}assets/icons/linkdin_icon.png',
              onTap: () => _open(
                'https://www.linkedin.com/in/mohit-rajpurohit-8b9ba41a3/',
              ),
            ),
            _socialIcon(
              context,
              iconPath:
              '${AppConstants().configConstants.imageBaseUrl}assets/icons/Instagram_icon.png',
              onTap: () =>
                  _open('https://www.instagram.com/_mohit_rajguru/'),
            ),
          ],
        ),
      ],
    );
  }

  // ================= SOCIAL ICON =================
  Widget _socialIcon(
      BuildContext context, {
        required String iconPath,
        required VoidCallback onTap,
      }) {
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: colors.projectCardBorder),
          ),
          child: Image.network(
            iconPath,
            height: 18,
            width: 18,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.link, size: 18),
          ),
        ),
      ),
    );
  }
}

/* =========================================================
   REAL TOGGLE SWITCH (ON / OFF)
   ========================================================= */

class ThemeToggleSwitch extends StatefulWidget {
  final AppColors colors;
  const ThemeToggleSwitch({super.key, required this.colors});

  @override
  State<ThemeToggleSwitch> createState() => _ThemeToggleSwitchState();
}

class _ThemeToggleSwitchState extends State<ThemeToggleSwitch> {
  bool _isLoading = false;

  bool get _isDark =>
      (themeController.effectiveMode) ==
          AppThemeMode.dark;

  Future<void> _onToggle(bool value) async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    themeController.setTheme(
      value ? AppThemeMode.dark : AppThemeMode.light,
    );

    // Smooth UX delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;
    final bool isDarkTheme = colors.isDark;

    return AnimatedToggleSwitch<bool>.dual(
      current: _isDark,
      first: false,
      second: true,
      height: 30,
      spacing: 0,
      indicatorSize: const Size(25, 25),
      loading: _isLoading,
      onChanged: _onToggle,

      /// TRACK + THUMB STYLING
      styleBuilder: (value) {
        return ToggleStyle(
          backgroundColor: isDarkTheme
              ? const Color(0xFF2A2A2A) // dark track
              : const Color(0xFFE5E7EB), // light track
          indicatorColor: value
              ? (isDarkTheme ? Colors.white : const Color(0xFF111111))
              : (isDarkTheme ? Colors.white : const Color(0xFF111111)),
          borderRadius: BorderRadius.circular(20),
        );
      },

      /// ICON
      iconBuilder: (value) {
        final bool isOn = value;

        return Icon(
          isOn ? Icons.dark_mode : Icons.light_mode,
          size: 16,
          color: isOn
              ? (isDarkTheme
              ? const Color(0xFF111111) // dark icon on light thumb
              : Colors.white)          // light icon on dark thumb
              : (isDarkTheme
              ? const Color(0xFF111111)
              : Colors.white),
        );
      },
    );
  }

}
