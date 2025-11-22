import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  // NEW About paragraph
  static const String aboutParagraph = '''
I am a cross-platform Software Developer with experience across Android Kotlin, Flutter, React Native, Next.js, and AI-driven backend systems. 
Starting from Android & Flutter during my internship days, I grew into a full-stack engineer capable of building mobile apps, web platforms, real-time AI assistants, and scalable backend APIs.
My work spans AI automation, R&D, FastAPI/LangChain integrations, cloud deployments, ML/AR demos, and delivering production-ready applications for clients.
''';

  // UPDATED TIMELINE
  final List<Map<String, String>> _timeline = const [
    {
      'time': '2023',
      'title': 'Foundation & Internship',
      'desc': 'AI Chef (Flutter+Firebase), Kirana Friends (Android Kotlin). Learned full app lifecycle.',
      'icon': 'assets/images/icon_mobile.png',
    },
    {
      'time': '2024',
      'title': 'Professional Growth',
      'desc': 'Vehya: AI chat, ML Kit, ARKit demo, R&D, Flutter advanced development.',
      'icon': 'assets/images/icon_ai_timeline.png',
    },
    {
      'time': '2025',
      'title': 'Cross-Platform Expansion',
      'desc': 'Sendee, Kurudy, Nandi ERP — NextJS, React Native, APIs, Stripe/Plaid, AI training phase.',
      'icon': 'assets/images/icon_web.png',
    },
    {
      'time': 'Late 2025 - Present',
      'title': 'Full-Stack + Cloud',
      'desc': 'Disctopia & Wavve: NextJS, NestJS, AWS, deployments, scalable backend work.',
      'icon': 'assets/images/icon_experience.png',
    },
  ];

  // UPDATED SKILLS
  final List<String> _skills = const [
    // Expert
    'Flutter (Expert)',
    'Dart (Expert)',

    // Intermediate
    'React Native (Intermediate)',
    'Next.js (Intermediate)',
    'TypeScript (Intermediate)',
    'Python (Intermediate)',
    'FastAPI (Intermediate)',
    'LangChain (Intermediate)',
    'Firebase (Intermediate)',
    'Firestore (Intermediate)',
    'Stripe (Intermediate)',
    'Plaid (Intermediate)',
    'NodeJS (Intermediate)',

    // Beginner
    'Android Kotlin (Beginner)',
    'NestJS (Beginner)',
    'AWS (Beginner)',
    'HuggingFace (Beginner)',
    'ARKit (Beginner)',
    'ML Kit (Beginner)',
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

  // ---------------- Two Column Layout ----------------
  Widget _buildTwoColumn(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('About Me'),
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

        // Right Column
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

  // ---------------- Single Column Layout (Mobile) ----------------
  Widget _buildSingleColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _sectionTitle('About Me'),
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

  // ---------------- Section Title ----------------
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

  // ---------------- Highlight Cards ----------------
  Widget _highlightCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Expanded(child: _MiniHighlightCard(
          iconPath: 'assets/images/icon_app.png',
          title: 'App Development',
          subtitle: 'Android, Flutter & React Native apps with production deployments.',
        )),
        SizedBox(width: 12),
        Expanded(child: _MiniHighlightCard(
          iconPath: 'assets/images/icon_web.png',
          title: 'Web Development',
          subtitle: 'Next.js platforms, ERP dashboards & scalable backend integrations.',
        )),
        SizedBox(width: 12),
        Expanded(child: _MiniHighlightCard(
          iconPath: 'assets/images/icon_ai.png',
          title: 'AI Systems',
          subtitle: 'AI assistants, LangChain, FastAPI, Vapi AI & automation workflows.',
        )),
      ],
    );
  }

  // ---------------- Achievements Block ----------------
  Widget _achievementsBlock() {
    final achievements = [
      'Developed cross-platform apps: Android Kotlin, Flutter, React Native.',
      'Implemented AI chat logic, predicate workflows & voice automation (Vapi AI).',
      'Built scalable web platforms using Next.js, NodeJS/NestJS & Stripe/Plaid.',
      'Delivered ML & AR demos using Firebase ML Kit and ARKit.',
      'Worked on live production systems (Sendee, Kurudy, Nandi ERP, Disctopia, Wavve).',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Key Achievements',
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

  // ---------------- Skills Section ----------------
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

  // ---------------- Profile Card ----------------
  Widget _profileCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            'assets/images/about_mohit.png',
            height: 140,
            width: 140,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) {
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
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mohit Rajpurohit',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'Cross-platform Developer — Android • Flutter • React Native • Web • AI',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        )
      ],
    );
  }

  // ---------------- About Paragraph ----------------
  Widget _aboutParagraph() {
    return Text(
      aboutParagraph,
      style: const TextStyle(fontSize: 15.5, height: 1.6, color: Colors.black87),
    );
  }

  // ---------------- Timeline ----------------
  Widget _timelineWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Experience Timeline', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),
        Column(
          children: _timeline.map((e) => _timelineItem(e)).toList(),
        ),
      ],
    );
  }

  Widget _timelineItem(Map<String, String> event) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,2))
              ],
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
          )
        ],
      ),
    );
  }

  // ---------------- Resume Buttons ----------------
  Widget _resumeButtons(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () {},
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
          onPressed: () {},
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

            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 6),

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

