import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Skills & Technologies",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Toolsets & frameworks I use to build intelligent mobile, web, and AI-driven systems.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.55,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 50),

          LayoutBuilder(builder: (context, constraints) {
            int columns = constraints.maxWidth > 1100
                ? 3
                : constraints.maxWidth > 700
                ? 2
                : 1;

            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: columns,
              childAspectRatio: 1.2,
              crossAxisSpacing: 32,
              mainAxisSpacing: 32,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // MOBILE DEV
                _skillCategory(
                  "Mobile Development",
                  [
                    {
                      "name": "Flutter",
                      "level": 0.95,
                      "icon": "assets/skills/flutter.png"
                    },
                    {
                      "name": "Dart",
                      "level": 0.92,
                      "icon": "assets/skills/dart.png"
                    },
                    {
                      "name": "React Native",
                      "level": 0.70,
                      "icon": "assets/skills/react_native.png"
                    },
                    {
                      "name": "Android Kotlin",
                      "level": 0.40,
                      "icon": "assets/skills/kotlin.png"
                    },
                  ],
                ),

                // WEB DEV
                _skillCategory(
                  "Web Development",
                  [
                    {
                      "name": "Next.js",
                      "level": 0.75,
                      "icon": "assets/skills/nextjs.png"
                    },
                    {
                      "name": "React.js",
                      "level": 0.72,
                      "icon": "assets/skills/react.png"
                    },
                    {
                      "name": "TypeScript",
                      "level": 0.70,
                      "icon": "assets/skills/typescript.png"
                    },
                  ],
                ),

                // BACKEND + AI
                _skillCategory(
                  "Backend • AI • Cloud",
                  [
                    {
                      "name": "Python",
                      "level": 0.75,
                      "icon": "assets/skills/python.png"
                    },
                    {
                      "name": "FastAPI",
                      "level": 0.72,
                      "icon": "assets/skills/fastapi.png"
                    },
                    {
                      "name": "LangChain",
                      "level": 0.68,
                      "icon": "assets/skills/langchain.png"
                    },
                    {
                      "name": "Firebase",
                      "level": 0.78,
                      "icon": "assets/skills/firebase.png"
                    },
                    {
                      "name": "NodeJS",
                      "level": 0.65,
                      "icon": "assets/skills/nodejs.png"
                    },
                    {
                      "name": "NestJS",
                      "level": 0.45,
                      "icon": "assets/skills/nestjs.png"
                    },
                    {
                      "name": "AWS",
                      "level": 0.40,
                      "icon": "assets/skills/aws.png"
                    },
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  // ---------------- SKILL CATEGORY BOX ----------------
  Widget _skillCategory(String title, List<Map<String, dynamic>> skills) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CATEGORY TITLE
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 18),

          // SKILL LIST
          ...skills.map((skill) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _skillWithProgress(
              skill['name'],
              skill['level'],
              skill['icon'],
            ),
          )),
        ],
      ),
    );
  }

  // ---------------- INDIVIDUAL SKILL BAR ----------------
  Widget _skillWithProgress(String name, double percent, String iconPath) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ICON
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            iconPath,
            height: 36,
            width: 36,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 36,
              width: 36,
              color: Colors.grey.shade200,
              child: const Icon(Icons.code, size: 20),
            ),
          ),
        ),

        const SizedBox(width: 14),

        // NAME + BAR
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SKILL NAME
              Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              // PROGRESS BAR
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: percent),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOut,
                builder: (context, value, _) => Container(
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        // PERCENT LABEL
        Text(
          "${(percent * 100).round()}%",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
