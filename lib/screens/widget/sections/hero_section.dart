import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // LEFT SECTION (Text Content)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NAME
              const Text(
                "Mohit Rajpurohit",
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 18),

              // SHORT TAGLINE
              Text(
                "Software Developer — App • Web • AI",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.85),
                ),
              ),

              const SizedBox(height: 26),

              // MEDIUM TAGLINE (3 LINES)
              SizedBox(
                width: 500,
                child: Text(
                  "Building intelligent digital experiences across mobile, web,\n"
                      "and AI-driven ecosystems. From powerful AI assistants to\n"
                      "real-world apps and scalable production systems.",
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.55,
                    color: Colors.black.withOpacity(0.80),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // BUTTONS
              Row(
                children: [
                  // PROJECTS BUTTON
                  ElevatedButton(
                    onPressed: () {
                      // scroll from navbar will be used
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 34,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      "View Projects",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  const SizedBox(width: 20),

                  // DOWNLOAD RESUME BUTTON (outlined premium style)
                  OutlinedButton(
                    onPressed: () {
                      // open resume later
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 34,
                        vertical: 18,
                      ),
                      side: BorderSide(
                        color: Colors.black.withOpacity(0.8),
                        width: 1.4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Download Resume",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // RIGHT SECTION (Profile Photo)
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              "assets/images/hero_mohit.png",
              height: 420,
              width: 420,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
