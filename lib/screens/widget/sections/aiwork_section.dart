import 'package:flutter/material.dart';

class AIWorkSection extends StatelessWidget {
  const AIWorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "AI Work — Intelligent Systems & Automation",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: 800,
            child: Text(
              "I build AI-driven systems such as predicate-based chat logic, "
                  "voice assistants, reasoning-enabled backend APIs, OCR demos, "
                  "AR-powered experiences, and structured prompt engineering flows.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.55,
                color: Colors.black.withOpacity(0.80),
              ),
            ),
          ),
          const SizedBox(height: 48),

          LayoutBuilder(
            builder: (context, constraints) {
              int count = constraints.maxWidth > 1000
                  ? 3
                  : constraints.maxWidth > 650
                  ? 2
                  : 1;

              return GridView.count(
                shrinkWrap: true,
                crossAxisCount: count,
                childAspectRatio: 1.25,
                crossAxisSpacing: 22,
                mainAxisSpacing: 22,
                physics: const NeverScrollableScrollPhysics(),
                children: _aiCards.map((p) {
                  return AICard(
                    title: p['title']!,
                    desc: p['desc']!,
                    tech: p['tech']!,
                    background: p['background']!,
                    icons: p['icons']!,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  // -------- AI CARD DATA -----------
  static final List<Map<String, dynamic>> _aiCards = [
    {
      "title": "AI Bot Assistant",
      "desc": "Predicate logic, dynamic flows, state-based reasoning and multi-condition AI responses.",
      "tech": ["FastAPI", "LangChain", "Predicates", "Python"],
      "background": "assets/images/ai_bot_bg.jpg",
      "icons": [
        "assets/ai/icons/robot.png",
        "assets/ai/icons/logic.png",
        "assets/ai/icons/chat.png",
      ],
    },
    {
      "title": "Vapi Voice Assistant",
      "desc": "Live voice ↔ API ↔ AI workflow enabling spoken intelligent responses.",
      "tech": ["Vapi AI", "Audio API", "FastAPI"],
      "background": "assets/ai/backgrounds/vapi_bg.png",
      "icons": [
        "assets/ai/icons/mic.png",
        "assets/ai/icons/voice.png",
        "assets/ai/icons/api.png",
      ],
    },
    {
      "title": "LangChain + FastAPI Backend",
      "desc": "Reasoning-enabled backend with structured prompt templates.",
      "tech": ["LangChain", "FastAPI", "Python"],
      "background": "assets/ai/backgrounds/langchain_bg.png",
      "icons": [
        "assets/ai/icons/langchain.png",
        "assets/ai/icons/template.png",
        "assets/ai/icons/brain.png",
      ],
    },
    {
      "title": "ML Kit OCR Demo",
      "desc": "OCR for address extraction and structured text understanding.",
      "tech": ["MLKit", "Firebase", "Flutter"],
      "background": "assets/ai/backgrounds/mlkit_bg.png",
      "icons": [
        "assets/ai/icons/ocr.png",
        "assets/ai/icons/text.png",
        "assets/ai/icons/camera.png",
      ],
    },
    {
      "title": "ARKit Human Detection",
      "desc": "Counts humans in the camera frame using ARKit processing.",
      "tech": ["ARKit", "Flutter"],
      "background": "assets/ai/backgrounds/arkit_bg.png",
      "icons": [
        "assets/ai/icons/arkit.png",
        "assets/ai/icons/human.png",
        "assets/ai/icons/frame.png",
      ],
    },
    {
      "title": "Python AI Exploration",
      "desc": "Advanced R&D: HuggingFace, model testing, prompt engineering.",
      "tech": ["Python", "HuggingFace", "R&D"],
      "background": "assets/ai/backgrounds/python_bg.png",
      "icons": [
        "assets/ai/icons/python.png",
        "assets/ai/icons/hf.png",
        "assets/ai/icons/rnd.png",
      ],
    },
  ];
}


class AICard extends StatelessWidget {
  final String title;
  final String desc;
  final List<String> tech;
  final String background;
  final List<String> icons;

  const AICard({
    super.key,
    required this.title,
    required this.desc,
    required this.tech,
    required this.background,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('assets/images/pf_profile.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.55),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // TITLE
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 10),

          // DESCRIPTION
          Text(
            desc,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.white.withOpacity(0.9),
            ),
          ),

          const Spacer(),

          // 3 ICONS (60 x 60 each)
          Row(
            children: icons.map((icon) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    icon,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(height: 60, width: 60, color: Colors.white24),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // TECH TAGS
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tech.map((t) {
              return Chip(
                label: Text(t),
                labelStyle: const TextStyle(color: Colors.white),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.white.withOpacity(0.25)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
