import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/app_constants.dart';
import '../services/remote_config_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

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
        TextButton.icon(
          onPressed: () => _open(
            'https://raw.githubusercontent.com/mrmohitrajpurohit/mohit-portfolio/main/Mohit%20Resume%20Oct%2002%2C%202025.pdf',
          ),
          icon: Icon(Icons.download, size: 16, color: colors.textPrimary),
          label: Text(
            "Resume",
            style: textStyles.navItemMobile,
          ),
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
            IconButton(
              icon: Icon(Icons.download, color: colors.textPrimary),
              onPressed: () => _open(
                'https://raw.githubusercontent.com/mrmohitrajpurohit/mohit-portfolio/main/Mohit%20Resume%20Oct%2002%2C%202025.pdf',
              ),
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
