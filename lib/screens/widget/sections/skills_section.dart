import 'dart:math';
import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Skills & Technologies",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 0.4,
            ),
          ),

          const SizedBox(height: 14),

          const SizedBox(
            width: 820,
            child: Text(
              "Technologies, frameworks, and platforms I’ve worked with to build scalable mobile, web, and AI-driven systems.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ),

          const SizedBox(height: 70),

          LayoutBuilder(builder: (context, constraints) {
            int columns = constraints.maxWidth > 1100
                ? 3
                : constraints.maxWidth > 700
                ? 2
                : 1;

            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: columns,
              crossAxisSpacing: 40,
              mainAxisSpacing: 40,
              childAspectRatio: 1.15,
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

        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.white.withOpacity(0.18),
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A), // dark slate
              Color(0xFF020617), // near black
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
                  child: Column(
                    children: [
                      ...skills.map(
                            (skill) => Padding(
                          padding: const EdgeInsets.only(bottom: 22),
                          child: _skillRow(
                            skill['name'],
                            skill['level'],
                            skill['icon'],
                          ),
                        ),
                      ),
                    ],
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
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
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

  // ================= GLOW BLOBS =================
  Widget _glowBlob(
      {double? top,
        double? left,
        double? right,
        double? bottom,
        required Color color}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(0.45),
              Colors.transparent,
            ],
          ),
        ),
      ),
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
        Matrix4.translationValues(0, hover ? -12 : 0, 0)..scale(hover ? 1.03 : 1),
        child: widget.child,
      ),
    );
  }
}
