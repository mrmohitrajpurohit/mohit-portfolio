import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ['App Development', 'Web Development', 'AI Work'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ----------------- DATA -----------------
  // Project entries use asset paths you will add under assets/projects/...
  final List<Map<String, dynamic>> _appProjects = [
    {
      'title': 'AI Chef',
      'thumb': 'assets/projects/ai_chef/app_1.png',
      'desc': 'Recipe suggestion app: build recipes from ingredients. College project (Flutter + Firebase + NodeJS).',
      'tech': ['Flutter', 'Firebase', 'NodeJS'],
      'playStore': null,
      'live': null,
      'status': 'Demo',
    },
    {
      'title': 'Kirana Friends',
      'thumb': 'assets/projects/kirana/app_1.png',
      'desc': 'Community app for kirana operators. Android Kotlin app (internship).',
      'tech': ['Android (Kotlin)'],
      'playStore': null,
      'live': null,
      'status': 'Inactive',
    },
    {
      'title': 'Vehya',
      'thumb': 'assets/projects/vehya/app_1.png',
      'desc': 'Marketplace with AI chat support and ML/AR demos. Flutter + Firebase.',
      'tech': ['Flutter', 'Firebase', 'AI Chat'],
      'playStore': null,
      'live': null,
      'status': 'Inactive',
    },
    {
      'title': 'Sendee',
      'thumb': 'assets/projects/sendee/app_1.png',
      'desc': 'Service marketplace app with unique UI and booking flows.',
      'tech': ['Flutter', 'Next.js'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.sendee.customer&hl=en_IN',
      'live': 'https://sendee.com/home',
      'status': 'Live',
    },
    {
      'title': 'Kurudy (App)',
      'thumb': 'assets/projects/kurudy/app_1.png',
      'desc': 'Investment platform mobile app (React Native).',
      'tech': ['React Native', 'NodeJS'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.kurudy&hl=en_IN',
      'live': 'https://www.kurudy.com/',
      'status': 'Live',
    },
    {
      'title': 'Disctopia (App)',
      'thumb': 'assets/projects/disctopia/app_1.png',
      'desc': 'Music & Podcasts mobile app with creator-first features.',
      'tech': ['React Native', 'Firebase'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.disctopia.android&hl=en_IN',
      'live': 'https://disctopia.com/',
      'status': 'Live',
    },
  ];

  final List<Map<String, dynamic>> _webProjects = [
    {
      'title': 'AI Chef (Web)',
      'thumb': 'assets/projects/web/ai_chef_web.png',
      'desc': 'Web client for the AI Chef experience (Flutter Web).',
      'tech': ['Flutter Web', 'Firebase'],
      'live': null,
      'status': 'Demo',

    },
    {
      'title': 'Sendee (Web)',
      'thumb': 'assets/projects/web/sendee_web.png',
      'desc': 'Sendee web portal built with Next.js.',
      'tech': ['Next.js'],
      'live': 'https://sendee.com/home',
      'status': 'Live',
      'screenshots': [
        'assets/projects/sendee/screens/s1.png',
        'assets/projects/sendee/screens/s2.png',
        'assets/projects/sendee/screens/s3.png',
      ],
    },
    {
      'title': 'Kurudy (Web)',
      'thumb': 'assets/projects/web/kurudy_web.png',
      'desc': 'Kurudy investor portal and marketing site (Next.js).',
      'tech': ['Next.js'],
      'live': 'https://www.kurudy.com/',
      'status': 'Live',
    },
    {
      'title': 'Nandi Food ERP',
      'thumb': 'assets/projects/web/nandi_web.png',
      'desc': 'ERP for Nandi Food — inventory and business management.',
      'tech': ['Next.js', 'NodeJS'],
      'live': 'https://erp.nandifoods.com/login',
      'status': 'Live',
    },
    {
      'title': 'Disctopia (Web)',
      'thumb': 'assets/projects/web/disctopia_web.png',
      'desc': 'Disctopia web streaming and creator tools (Next.js).',
      'tech': ['Next.js'],
      'live': 'https://disctopia.com/',
      'status': 'Live',
    },
    {
      'title': 'Wavve (Web)',
      'thumb': 'assets/projects/web/wavve_web.png',
      'desc': 'Podcast tools & clip creation (Next.js + AWS).',
      'tech': ['Next.js', 'AWS'],
      'live': 'https://power.wavve.co/',
      'status': 'Live',
    },
  ];

  final List<Map<String, dynamic>> _aiProjects = [
    {
      'title': 'AI Bot Assistant',
      'thumb': 'assets/projects/ai/ai_assistant.png',
      'desc': 'Predicate-driven AI assistant: multi-step logic, context management, and prediction-based flows.',
      'tech': ['FastAPI', 'LangChain', 'Prompt Engineering'],
      'live': null,
      'status': 'R&D',
    },
    {
      'title': 'Vapi Voice Assistant',
      'thumb': 'assets/projects/ai/vapi_voice.png',
      'desc': 'Voice automation: real-time voice ↔ API ↔ AI ↔ voice loops for meaningful spoken responses.',
      'tech': ['Vapi AI', 'WebRTC', 'FastAPI'],
      'live': null,
      'status': 'Demo',
    },
    {
      'title': 'FastAPI + LangChain Backends',
      'thumb': 'assets/projects/ai/langchain.png',
      'desc': 'Reasoning-enabled API endpoints with structured prompt templates and context management.',
      'tech': ['FastAPI', 'LangChain', 'Python'],
      'live': null,
      'status': 'R&D',
    },
    {
      'title': 'Firebase ML Kit (OCR)',
      'thumb': 'assets/projects/ai/mlkit.png',
      'desc': 'OCR extraction and data parsing demos (address extraction and image-to-text pipelines).',
      'tech': ['Firebase ML Kit', 'Flutter'],
      'live': null,
      'status': 'Demo',
    },
    {
      'title': 'ARKit Human Detection',
      'thumb': 'assets/projects/ai/arkit.png',
      'desc': 'ARKit demo to detect number of humans and overlay information (Flutter + ARKit).',
      'tech': ['ARKit', 'Flutter'],
      'live': null,
      'status': 'Demo',
    },
  ];

  // ----------------- BUILD -----------------
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 40),
      child: Column(
        children: [
          _sectionHeader(),
          const SizedBox(height: 18),
          _tabBar(),
          const SizedBox(height: 24),
          SizedBox(
            // gives grid space for cards
            width: double.infinity,
            child: _tabController.index == 0
                ? _gridFor(_appProjects)
                : _tabController.index == 1
                ? _gridFor(_webProjects)
                : _gridFor(_aiProjects),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader() {
    return Column(
      children: const [
        Text('Projects', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text(
          'Selected work across mobile, web, and AI. Click a tab to filter by category.',
          style: TextStyle(color: Colors.black87),
        ),
      ],
    );
  }

  Widget _tabBar() {
    return TabBar(
      controller: _tabController,
      onTap: (i) => setState(() {}),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black54,
      indicatorColor: Colors.black,
      tabs: tabs.map((t) => Tab(text: t)).toList(),
    );
  }

  Widget _gridFor(List<Map<String, dynamic>> list) {
    // responsive column count
    return LayoutBuilder(builder: (context, c) {
      int crossAxisCount = 1;
      final width = c.maxWidth;
      if (width > 1200) crossAxisCount = 3;
      else if (width > 800) crossAxisCount = 2;
      else crossAxisCount = 1;

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          final p = list[index];
          return ProjectCard(
            title: p['title'],
            thumbnailPath: p['thumb'],
            description: p['desc'],
            techTags: List<String>.from(p['tech']),
            status: p['status'],
            liveLink: p['live'],
            playStoreLink: p['playStore'],
            screenshots: p['screenshots'] ?? [],
          );
        },
      );
    });
  }
}


class ProjectCard extends StatefulWidget {
  final String title;
  final String thumbnailPath;
  final String description;
  final List<String> techTags;
  final String? liveLink;
  final String? playStoreLink;
  final String status;
  final List<String> screenshots; // NEW

  const ProjectCard({
    super.key,
    required this.title,
    required this.thumbnailPath,
    required this.description,
    required this.techTags,
    this.liveLink,
    this.playStoreLink,
    this.status = 'Live',
    required this.screenshots, // NEW
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hover = false;

  void _openLink(String? url) async {
    if (url == null) return;
    try {
      await launchUrlString(url, webOnlyWindowName: '_blank');
    } catch (e) {
      // ignore
    }
  }

  void _openGallery() {
    if (widget.screenshots.isEmpty) return;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _ProjectGalleryModal(
        title: widget.title,
        screenshots: widget.screenshots,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 160),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0,6)),
            ],
          ),
          child: Column(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  widget.thumbnailPath,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    height: 150,
                    color: Colors.grey.shade100,
                    child: const Center(child: Icon(Icons.image_not_supported, size: 48, color: Colors.black26)),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Status
                    Row(
                      children: [
                        Expanded(
                          child: Text(widget.title, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w600)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: widget.status == 'Live' ? Colors.green.shade50 : Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(widget.status, style: TextStyle(color: widget.status == 'Live' ? Colors.green.shade800 : Colors.orange.shade800, fontSize: 12)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Description
                    Text(widget.description, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14.0, color: Colors.black87)),

                    const SizedBox(height: 10),

                    // Tech tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: widget.techTags.map((t) => Chip(
                        label: Text(t, style: const TextStyle(fontSize: 12)),
                        backgroundColor: Colors.grey.shade100,
                        visualDensity: VisualDensity.compact,
                      )).toList(),
                    ),

                    const SizedBox(height: 12),

                    // Action buttons
                    Row(
                      children: [
                        if (widget.screenshots.isNotEmpty)
                          OutlinedButton(
                            onPressed: _openGallery,
                            child: const Text("Screenshots"),
                          ),
                        if (widget.playStoreLink != null)
                          ElevatedButton.icon(
                            onPressed: () => _openLink(widget.playStoreLink),
                            icon: const Icon(Icons.play_arrow, size: 16),
                            label: const Text('Play Store'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              textStyle: const TextStyle(fontSize: 13),
                            ),
                          ),
                        if (widget.playStoreLink != null) const SizedBox(width: 10),
                        if (widget.liveLink != null)
                          OutlinedButton.icon(
                            onPressed: () => _openLink(widget.liveLink),
                            icon: const Icon(Icons.open_in_new, size: 16),
                            label: const Text('Visit'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              side: BorderSide(color: Colors.grey.shade300),
                              textStyle: const TextStyle(fontSize: 13),
                            ),
                          ),
                        const Spacer(),
                        // Optional "More" (we can add modal later)
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectGalleryModal extends StatefulWidget {
  final String title;
  final List<String> screenshots;

  const _ProjectGalleryModal({
    required this.title,
    required this.screenshots,
  });

  @override
  State<_ProjectGalleryModal> createState() => _ProjectGalleryModalState();
}

class _ProjectGalleryModalState extends State<_ProjectGalleryModal> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // BACKGROUND BLUR
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(color: Colors.black.withOpacity(0.55)),
          ),
        ),

        // CENTERED MODAL
        Center(
          child: Container(
            width: 680,
            height: 480,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // TITLE + CLOSE BUTTON
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // SWIPE CAROUSEL
                Expanded(
                  child: PageView.builder(
                    itemCount: widget.screenshots.length,
                    onPageChanged: (i) => setState(() => page = i),
                    itemBuilder: (_, i) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          widget.screenshots[i],
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // DOT INDICATORS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.screenshots.length, (i) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: page == i ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: page == i ? Colors.black : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

