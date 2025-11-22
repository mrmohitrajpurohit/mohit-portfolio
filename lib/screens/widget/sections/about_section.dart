import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  // -- Edit these texts if you want to tweak copy quickly --
  static const String aboutParagraph = '''
I am a Software Developer with ~2 years of professional experience building cross-platform applications and AI-driven systems. 
I focus on clean architecture, modular components, and pragmatic AI integrations — from building voice-capable assistants (Vapi AI) and FastAPI-backed reasoning endpoints to consumer-facing mobile apps and responsive web experiences.
I enjoy exploring prompt engineering, prototype R&D, and turning logic into friendly conversational products.
''';

  // timeline events (year/label/description)
  final List<Map<String, String>> _timeline = const [
    {
      'time': '2023',
      'title': 'Mobile-first & Flutter',
      'desc': 'Built production mobile apps (Kurudy, Sendee, Disctopia) and demoed ML/AR features.',
      'icon': 'assets/images/icon_mobile.png',
    },
    {
      'time': '2024',
      'title': 'Web & Cross-platform',
      'desc': 'Developed Next.js web frontends and production websites; integrated payments & auth.',
      'icon': 'assets/images/icon_web.png',
    },
    {
      'time': '2025',
      'title': 'AI & Automation',
      'desc': 'Built Vapi AI assistants, FastAPI + LangChain backends, prompt engineering & voice automation.',
      'icon': 'assets/images/icon_ai_timeline.png',
    },
  ];

  // skills, used as chips
  final List<String> _skills = const [
    'Flutter', 'Dart', 'Next.js', 'React Native', 'FastAPI', 'Python',
    'LangChain', 'Stripe', 'Plaid', 'Firebase', 'Redux', 'ARKit', 'ML Kit'
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isWide = constraints.maxWidth >= 900;

      return Container(
        color: Colors.grey.shade50,
        padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 64),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isWide ? _buildTwoColumn(context) : _buildSingleColumn(context),
          ),
        ),
      );
    });
  }

  // Two column layout for desktop / wide screens
  Widget _buildTwoColumn(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column: highlights + achievements + skills
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('About'),
              const SizedBox(height: 18),
              _highlightCards(),
              const SizedBox(height: 28),
              _achievementsBlock(),
              const SizedBox(height: 26),
              _skillsWrap(),
              const SizedBox(height: 28),
              _resumeButtons(context),
            ],
          ),
        ),

        const SizedBox(width: 36),

        // Right column: photo + paragraph + timeline
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileCard(),
              const SizedBox(height: 24),
              _aboutParagraph(),
              const SizedBox(height: 28),
              _timelineWidget(),
            ],
          ),
        ),
      ],
    );
  }

  // Single column layout for mobile / small screens
  Widget _buildSingleColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _sectionTitle('About'),
        const SizedBox(height: 16),
        _profileCard(),
        const SizedBox(height: 18),
        _aboutParagraph(),
        const SizedBox(height: 18),
        _highlightCards(),
        const SizedBox(height: 18),
        _achievementsBlock(),
        const SizedBox(height: 18),
        _skillsWrap(),
        const SizedBox(height: 18),
        _timelineWidget(),
        const SizedBox(height: 18),
        _resumeButtons(context),
      ],
    );
  }

  // Title widget
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.2,
      ),
    );
  }

  // 3 highlight cards: App / Web / AI
  Widget _highlightCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Expanded(child: _MiniHighlightCard(
          iconPath: 'assets/images/icon_app.png',
          title: 'App Development',
          subtitle: 'End-to-end mobile apps (Flutter & React Native), real-time flows & client demos.',
        )),
        SizedBox(width: 12),
        Expanded(child: _MiniHighlightCard(
          iconPath: 'assets/images/icon_web.png',
          title: 'Web Development',
          subtitle: 'Responsive Next.js & Angular projects — production-ready web experiences.',
        )),
        SizedBox(width: 12),
        Expanded(child: _MiniHighlightCard(
          iconPath: 'assets/images/icon_ai.png',
          title: 'AI-Driven Systems',
          subtitle: 'AI assistants, FastAPI backends, prompt engineering & voice automation.',
        )),
      ],
    );
  }

  // Achievements block (bulleted)
  Widget _achievementsBlock() {
    final achievements = [
      'Built cross-platform apps (Kurudy, Sendee, Disctopia) and web products.',
      'Integrated secure payments (Stripe), Plaid, and auth workflows.',
      'Designed AI assistants with predicate-driven flows and context-aware responses.',
      'Delivered client demos: ARKit human detection & Firebase ML Kit OCR.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Key achievements',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ...achievements.map((a) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 4, right: 10),
                child: Icon(Icons.check_circle_outline, size: 18, color: Colors.black54),
              ),
              Expanded(child: Text(a, style: const TextStyle(fontSize: 15, height: 1.45))),
            ],
          ),
        )),
      ],
    );
  }

  // Skills wrap
  Widget _skillsWrap() {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: _skills.map((s) => Chip(
        label: Text(s, style: const TextStyle(fontSize: 13)),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
      )).toList(),
    );
  }

  // Profile card with image (uses about_mohit.png)
  Widget _profileCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile image with graceful fallback if asset missing
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            'assets/images/about_mohit.png',
            height: 140,
            width: 140,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 140,
                width: 140,
                color: Colors.grey.shade200,
                child: const Icon(Icons.person, size: 64, color: Colors.black26),
              );
            },
          ),
        ),

        const SizedBox(width: 18),

        // Short header next to image
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Mohit Rajpurohit',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'Software Developer — App • Web • AI',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // About paragraph
  Widget _aboutParagraph() {
    return Text(
      aboutParagraph,
      style: const TextStyle(fontSize: 15.5, height: 1.6, color: Colors.black87),
    );
  }

  // Timeline widget
  Widget _timelineWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Experience timeline', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),
        Column(
          children: _timeline.map((e) => _timelineItem(e)).toList(),
        ),
      ],
    );
  }

  // single timeline item
  Widget _timelineItem(Map<String, String> event) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // icon
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,2))],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                event['icon'] ?? '',
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) => const Icon(Icons.work_outline, color: Colors.black54),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event['time'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(event['title'] ?? '', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(event['desc'] ?? '', style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Resume buttons (Download / View)
  Widget _resumeButtons(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // open resume file in new tab or download
            // We'll wire this in later to open 'assets/files/Mohit_Resume.pdf'
          },
          icon: const Icon(Icons.picture_as_pdf, size: 18),
          label: const Text('View Resume'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

        const SizedBox(width: 12),

        OutlinedButton.icon(
          onPressed: () {
            // download action - handled later
          },
          icon: const Icon(Icons.download_outlined, size: 18),
          label: const Text('Download PDF'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ],
    );
  }


}

class _MiniHighlightCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;

  const _MiniHighlightCard({
    required this.iconPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ICON
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                iconPath,
                height: 32,
                width: 32,
                fit: BoxFit.contain,
                errorBuilder: (context, e, s) =>
                const Icon(Icons.extension, size: 32, color: Colors.black54),
              ),
            ),

            const SizedBox(height: 14),

            // TITLE
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 6),

            // SUBTITLE
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.black.withOpacity(0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

