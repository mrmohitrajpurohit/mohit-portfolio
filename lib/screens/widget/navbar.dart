import 'package:flutter/material.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 800;

        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 20,
            vertical: isMobile ? 10 : 20,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 40,
            vertical: isMobile ? 14 : 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.88),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: isMobile ? _mobileNav() : _desktopNav(),
        );
      },
    );
  }

  // ================= DESKTOP NAV =================
  Widget _desktopNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Mohit Rajpurohit",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        Row(
          children: [
            _navButton("Home", widget.onHome),
            _navButton("Projects", widget.onProjects),
            _navButton("AI Work", widget.onAIWork),
            _navButton("Achievements", widget.onAchievement),
            _navButton("Skills", widget.onSkills),
            _navButton("Contact", widget.onContact),
          ],
        ),
      ],
    );
  }

  // ================= MOBILE NAV =================
  Widget _mobileNav() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Row 1: Name
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Mohit",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Row 2: Swiper
        SizedBox(
          height: 36,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index) {
              _items[index].onTap();
            },
            itemBuilder: (_, index) {
              return Center(
                child: AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double? scale = 1.0;

                    if (_pageController.position.haveDimensions) {
                      final page =
                          _pageController.page ?? _pageController.initialPage;
                      scale = (1 - (page - index).abs())
                          .clamp(0.85, 1.0) as double?;
                    }

                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      _items[index].label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ================= SHARED BUTTON =================
  Widget _navButton(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
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
