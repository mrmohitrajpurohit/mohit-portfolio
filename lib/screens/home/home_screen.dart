import 'package:flutter/material.dart';
import 'package:mohit_portfolio/screens/contact_info/contact_info.dart';
import 'package:mohit_portfolio/screens/widget/sections/certifications_section.dart';

import '../../core/widgets/footer_section.dart';
import '../../view_model/home_view_model.dart';
import '../hero/hero.dart';
import '../widget/navbar.dart';
import '../widget/sections/aiwork_section.dart';
import '../widget/sections/projects_section.dart';
import '../widget/sections/skills_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  /// 🔁 FOOTER MODE SWITCH
  /// true  -> Sticky footer (always visible)
  /// false -> Footer appears at end of scroll
  final bool isStickyFooterEnabled = false;

  // SECTION KEYS
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final aiKey = GlobalKey();
  final achievementKey = GlobalKey();
  final skillsKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ================= MAIN SCROLL CONTENT =================
          Padding(
            // Leave space when sticky footer is enabled
            padding: EdgeInsets.only(
              bottom: isStickyFooterEnabled ? 80 : 0,
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(key: homeKey, child: const HeroSection()),
                  Container(key: projectsKey, child: const ProjectsSection()),
                  Container(key: aiKey, child: const AIWorkSection()),
                  Container(
                      key: achievementKey,
                      child: const CertificationsSection()),
                  Container(key: skillsKey, child: const SkillsSection()),
                  Container(
                    key: contactKey,
                    child: ContactInfo(model: HomeViewModel()),
                  ),

                  // Normal footer when sticky is OFF
                  if (!isStickyFooterEnabled) const FooterSection(),
                ],
              ),
            ),
          ),

          // ================= FLOATING NAVBAR =================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              onHome: () => scrollTo(homeKey),
              onAbout: () => scrollTo(aboutKey),
              onProjects: () => scrollTo(projectsKey),
              onAIWork: () => scrollTo(aiKey),
              onSkills: () => scrollTo(skillsKey),
              onAchievement: () => scrollTo(achievementKey),
              onContact: () => scrollTo(contactKey),
            ),
          ),

          // ================= STICKY FOOTER =================
          if (isStickyFooterEnabled)
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: FooterSection(isSticky: true),
            ),
        ],
      ),
    );
  }
}
