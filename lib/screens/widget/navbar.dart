import 'package:flutter/material.dart';
import 'package:mohit_portfolio/core/theme/app_colors.dart';
import 'package:mohit_portfolio/core/theme/app_text_styles.dart';

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
                borderRadius: BorderRadius.circular(14),
                boxShadow: colors.navbarShadow,
              ),
              child: isMobile
                  ? _mobileNav(colors, textStyles)
                  : _desktopNav(colors, textStyles),
            ),
          ],
        );
      },
    );
  }

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



/* ================= MODEL ================= */

class _NavItem {
  final String label;
  final VoidCallback onTap;
  _NavItem(this.label, this.onTap);
}
