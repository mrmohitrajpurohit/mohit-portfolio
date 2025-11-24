import 'package:flutter/material.dart';

import '../expandable_item.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            "Certifications • Achievements • Courses",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "A showcase of my verified accomplishments, credentials and professional milestones.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.55,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 50),

          LayoutBuilder(
            builder: (context, constraints) {
              int count = constraints.maxWidth > 1100
                  ? 3
                  : constraints.maxWidth > 700
                  ? 2
                  : 1;

              return GridView.count(
                shrinkWrap: true,
                crossAxisCount: count,
                crossAxisSpacing: 26,
                mainAxisSpacing: 26,
                childAspectRatio: 0.85,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildCard("Certifications", certificationsData,
                      "assets/icons/certificate.png"),
                  _buildCard("Achievements", achievementsData,
                      "assets/icons/achievement.png"),
                  _buildCard("Courses", coursesData,
                      "assets/icons/course.png"),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------- CARD UI ----------
  Widget _buildCard(String title, List<Map<String, dynamic>> items, String icon) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICON + TITLE
          Row(
            children: [
              Image.asset(
                icon,
                height: 34,
                width: 34,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.star_border, size: 30),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // LIST ITEMS
          Expanded(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: items
                  .map((item) => ExpandableItem(
                title: item['title'],
                subtitle: item['subtitle'] ?? "",
                imagePath: item['image'] ?? "",
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- CERTIFICATIONS DATA ----------
final List<Map<String, String>> certificationsData = [
  {
    "title": "Oracle Certified Foundation Associate",
    "subtitle": "Oracle • Jan 2022",
    "image": "assets/certifications/oracle_foundation.png"
  },
  {
    "title": "Android Webinar Participation",
    "subtitle": "May 2020",
    "image": "assets/certifications/android_webinar.png"
  },
  {
    "title": "Internal Hackathon Evaluation",
    "subtitle": "SSIU • March 2022",
    "image": "assets/certifications/hackathon_eval.png"
  },
  {
    "title": "AWS Billing & Cost Management",
    "subtitle": "AWS • Apr 2022",
    "image": "assets/certifications/aws_billing.png"
  },
  {
    "title": "Java Programming Certificate",
    "subtitle": "Great Learning • Oct 2021",
    "image": "assets/certifications/java_great_learning.png"
  },
  {
    "title": "CodeChef Go Code Participation",
    "subtitle": "Feb 2022",
    "image": "assets/certifications/codechef_go_code.png"
  },
  {
    "title": "MSME Entrepreneurship Program",
    "subtitle": "Nov 2021",
    "image": "assets/certifications/msme_program.png"
  },
];

// ---------- ACHIEVEMENTS DATA ----------
final List<Map<String, String>> achievementsData = [
  {
    "title": "5 Stars in Java",
    "subtitle": "HackerRank Competitive Programming",
    "image": ""
  },
  {
    "title": "Executive Member",
    "subtitle": "CodeChef SSIU Chapter",
    "image": ""
  },
  {
    "title": "Evaluator — Internal Hackathon",
    "subtitle": "SSIU Gandhinagar",
    "image": ""
  },
];

// ---------- COURSES DATA ----------
final List<Map<String, String>> coursesData = [
  {
    "title": "AWS Billing & Cost Management",
    "subtitle": "AWS Training • Apr 2022",
    "image": ""
  },
  {
    "title": "Java Programming",
    "subtitle": "Great Learning • Oct 2021",
    "image": ""
  },
  {
    "title": "Oracle Cloud Foundations 2021",
    "subtitle": "Oracle University • Jan 2022",
    "image": ""
  },
];
