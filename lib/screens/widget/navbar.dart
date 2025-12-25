import 'package:flutter/material.dart';
import 'package:mohit_portfolio/core/theme/app_colors.dart';
import 'package:mohit_portfolio/core/theme/app_text_styles.dart';
import 'package:mohit_portfolio/core/theme/app_theme_mode.dart';
import 'package:mohit_portfolio/main.dart';

class NavBar extends StatefulWidget {
  final VoidCallback onHome;
  final VoidCallback onAbout;
  final VoidCallback onProjects;
  final VoidCallback onAIWork;
  final VoidCallback onSkills;
  final VoidCallback onAchievement;
  final VoidCallback onContact;

  const NavBar({
    super.key,
    required this.onHome,
    required this.onAbout,
    required this.onProjects,
    required this.onAIWork,
    required this.onSkills,
    required this.onAchievement,
    required this.onContact,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final PageController _pageController =
  PageController(viewportFraction: 0.55);

  final List<_NavItem> _items = [];

  @override
  void initState() {
    super.initState();

    _items.addAll([
      _NavItem("Home", widget.onHome),
      _NavItem("Projects", widget.onProjects),
      _NavItem("AI Work", widget.onAIWork),
      _NavItem("Achievements", widget.onAchievement),
      _NavItem("Skills", widget.onSkills),
      _NavItem("Contact", widget.onContact),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textStyles = AppTextStyles.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 800;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // ================= MAIN NAVBAR =================
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 20,
                vertical: isMobile ? 10 : 20,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 40,
                vertical: isMobile ? 14 : 16,
              ),
              decoration: BoxDecoration(
                color: colors.navbarBackground,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14), bottomLeft: Radius.circular(14)),
                boxShadow: colors.navbarShadow,
              ),
              child: isMobile
                  ? _mobileNav(colors, textStyles)
                  : _desktopNav(colors, textStyles),
            ),

            // ================= THEME TOGGLE =================
            Positioned(
              right: isMobile ? 12 : 20,
              bottom: isMobile ? -16 : -18,
              child: ThemeModeToggle(colors: colors),
            ),
          ],
        );
      },
    );
  }

  // ================= DESKTOP NAV =================
  Widget _desktopNav(AppColors colors, AppTextStyles textStyles) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Mohit Rajpurohit", style: textStyles.navTitle),
        Row(
          children: [
            _navButton("Home", widget.onHome, textStyles),
            _navButton("Projects", widget.onProjects, textStyles),
            _navButton("AI Work", widget.onAIWork, textStyles),
            _navButton("Achievements", widget.onAchievement, textStyles),
            _navButton("Skills", widget.onSkills, textStyles),
            _navButton("Contact", widget.onContact, textStyles),
          ],
        ),
      ],
    );
  }

  // ================= MOBILE NAV =================
  Widget _mobileNav(AppColors colors, AppTextStyles textStyles) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Mohit", style: textStyles.navTitleMobile),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 36,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index) => _items[index].onTap(),
            itemBuilder: (_, index) {
              return Center(
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors.navbarBorder),
                  ),
                  child: Text(
                    _items[index].label,
                    style: textStyles.navItemMobile,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ================= NAV BUTTON =================
  Widget _navButton(
      String label,
      VoidCallback onTap,
      AppTextStyles textStyles,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Text(label, style: textStyles.navItem),
      ),
    );
  }
}

// ================= THEME MODE TOGGLE =================
class ThemeModeToggle extends StatelessWidget {
  final AppColors colors;
  const ThemeModeToggle({super.key, required this.colors});

  int _indexForMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 1;
      case AppThemeMode.dark:
        return 2;
      case AppThemeMode.system:
      default:
        return 0;
    }
  }

  void _onSelect(int index) {
    switch (index) {
      case 1:
        themeController.setTheme(AppThemeMode.light);
        break;
      case 2:
        themeController.setTheme(AppThemeMode.dark);
        break;
      default:
        themeController.setTheme(AppThemeMode.system);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _indexForMode(themeController.mode);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.navbarBackground,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(14), bottomLeft: Radius.circular(14)),
        boxShadow: colors.navbarShadow,
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            alignment: Alignment(-1 + selectedIndex * 1.0, 0),
            child: Container(
              width: 40,
              height: 34,
              decoration: BoxDecoration(
                color: colors.textPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _toggleIcon(Icons.brightness_auto, 0, selectedIndex),
              _toggleIcon(Icons.light_mode, 1, selectedIndex),
              _toggleIcon(Icons.dark_mode, 2, selectedIndex),
            ],
          ),
        ],
      ),
    );
  }

  Widget _toggleIcon(IconData icon, int index, int selectedIndex) {
    final isActive = index == selectedIndex;

    return GestureDetector(
      onTap: () => _onSelect(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 40,
        height: 34,
        child: Icon(
          icon,
          size: 18,
          color: isActive
              ? colors.navbarBackground
              : colors.textPrimary,
        ),
      ),
    );
  }
}

// ================= MODEL =================
class _NavItem {
  final String label;
  final VoidCallback onTap;
  _NavItem(this.label, this.onTap);
}
