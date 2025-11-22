import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onHome;
  final VoidCallback onAbout;
  final VoidCallback onProjects;
  final VoidCallback onAIWork;
  final VoidCallback onSkills;
  final VoidCallback onContact;

  const NavBar({
    super.key,
    required this.onHome,
    required this.onAbout,
    required this.onProjects,
    required this.onAIWork,
    required this.onSkills,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Name
          const Text(
            "Mohit",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),

          // Right: Links
          Row(
            children: [
              _navButton("Home", onHome),
              _navButton("About", onAbout),
              _navButton("Projects", onProjects),
              _navButton("AI Work", onAIWork),
              _navButton("Skills", onSkills),
              _navButton("Contact", onContact),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navButton(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap,
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
