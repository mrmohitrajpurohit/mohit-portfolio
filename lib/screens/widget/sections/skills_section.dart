import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 60,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Skills & Technologies",
            style: TextStyle(
              fontSize: isMobile ? 24 : 34,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 0.4,
            ),
          ),

          const SizedBox(height: 14),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Text(
              "Technologies, frameworks, and platforms I’ve worked with to build scalable mobile, web, and AI-driven systems.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 14 : 17,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ),

          SizedBox(height: isMobile ? 40 : 70),

          LayoutBuilder(builder: (context, constraints) {
            int columns = constraints.maxWidth > 1100
                ? 3
                : constraints.maxWidth > 700
                ? 2
                : 1;

            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: columns,
              crossAxisSpacing: isMobile ? 20 : 40,
              mainAxisSpacing: isMobile ? 20 : 40,
              childAspectRatio: columns == 1 ? 1.05 : 1.15,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _skillCategory("Mobile Development", [
                  {
                    "name": "Flutter",
                    "level": 0.95,
                    "icon": "assets/icons/flutter_icon.png"
                  },
                  {
                    "name": "Android/Kotlin",
                    "level": 0.92,
                    "icon": "assets/icons/kotlin_icon.png"
                  },
                  {
                    "name": "React Native",
                    "level": 0.70,
                    "icon": "assets/icons/reacts_icon.png"
                  },
                ]),
                _skillCategory("Web Development", [
                  {
                    "name": "Next.js",
                    "level": 0.75,
                    "icon": "assets/icons/nextjs.png"
                  },
                  {
                    "name": "React.js",
                    "level": 0.72,
                    "icon": "assets/icons/reacts_icon.png"
                  },
                  {
                    "name": "Flutter",
                    "level": 0.90,
                    "icon": "assets/icons/flutter_icon.png"
                  },
                ]),
                _skillCategory("Backend • AI • DevOps", [
                  {
                    "name": "Python",
                    "level": 0.30,
                    "icon": "assets/icons/python_icon.png"
                  },
                  {
                    "name": "FastAPI • LangChain",
                    "level": 0.30,
                    "icon": "assets/icons/fastapi_icon.png"
                  },
                  {
                    "name": "Firebase",
                    "level": 0.78,
                    "icon": "assets/icons/firebase_icon.png"
                  },
                  {
                    "name": "NodeJS",
                    "level": 0.20,
                    "icon": "assets/icons/nodejs_icon.png"
                  },
                  {
                    "name": ".NET • NestJS",
                    "level": 0.30,
                    "icon": "assets/icons/nestjs_icon.png"
                  },
                  {
                    "name": "AWS • Lambdas • Microservices",
                    "level": 0.50,
                    "icon": "assets/icons/aws_icon.png"
                  },
                  {
                    "name":
                    "Azure Portal • Azure Functions • Microservices",
                    "level": 0.50,
                    "icon": "assets/icons/azure_icon.png"
                  },
                ]),
              ],
            );
          }),
        ],
      ),
    );
  }

  // ================= SKILL CATEGORY CARD =================
  Widget _skillCategory(String title, List<Map<String, dynamic>> skills) {
    return _HoverLift(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.white.withOpacity(0.18),
          ),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0F172A),
              Color(0xFF020617),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.12),
                Colors.white.withOpacity(0.04),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 4,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF38BDF8),
                      Color(0xFFA855F7),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: skills
                        .map(
                          (skill) => Padding(
                        padding: const EdgeInsets.only(bottom: 22),
                        child: _skillRow(
                          skill['name'],
                          skill['level'],
                          skill['icon'],
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ================= INDIVIDUAL SKILL =================
  Widget _skillRow(String name, double percent, String iconPath) {
    return Row(
      children: [
        SizedBox(
          height: 46,
          width: 46,
          child: Image.asset(
            iconPath,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.code, color: Colors.white),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: percent),
                duration: const Duration(milliseconds: 1400),
                curve: Curves.easeOutExpo,
                builder: (_, value, __) => Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: value,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF38BDF8),
                            Color(0xFFA855F7),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        Text(
          "${(percent * 100).round()}%",
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ================= HOVER LIFT =================
class _HoverLift extends StatefulWidget {
  final Widget child;
  const _HoverLift({required this.child});

  @override
  State<_HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<_HoverLift> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform:
        Matrix4.translationValues(0, hover ? -12 : 0, 0)
          ..scale(hover ? 1.03 : 1),
        child: widget.child,
      ),
    );
  }
}
