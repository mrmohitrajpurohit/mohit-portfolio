import 'dart:ui';
import 'package:flutter/material.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allItems = [
      ...certificationsData,
      ...achievementsData,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 90),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            "Certifications & Achievements",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),

          const SizedBox(height: 14),

          const SizedBox(
            width: 760,
            child: Text(
              "Verified certifications, recognitions, and milestones that reflect my learning journey and professional growth.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ),

          const SizedBox(height: 60),

          LayoutBuilder(builder: (context, constraints) {
            int count = constraints.maxWidth > 1100
                ? 3
                : constraints.maxWidth > 700
                ? 2
                : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: count,
                crossAxisSpacing: 28,
                mainAxisSpacing: 28,
                childAspectRatio: 1.3,
              ),
              itemCount: allItems.length,
              itemBuilder: (_, i) {
                return _CertificateCard(item: allItems[i]);
              },
            );
          }),
        ],
      ),
    );
  }
}

// ================= CERTIFICATE CARD =================
class _CertificateCard extends StatefulWidget {
  final Map<String, dynamic> item;

  const _CertificateCard({required this.item});

  @override
  State<_CertificateCard> createState() => _CertificateCardState();
}

class _CertificateCardState extends State<_CertificateCard> {
  bool hover = false;

  void _openPreview(String imagePath) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _ImagePreviewDialog(imagePath: imagePath),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isShowEye =
        widget.item['isShowEye'] ?? true;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        // transform:
        // Matrix4.translationValues(0, hover ? -6 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              // Background
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),

                      child: Image.asset(
                                                widget.item['image']!,
                                                fit: BoxFit.contain,
                                                color: Colors.black.withOpacity(0.25),
                                                colorBlendMode: BlendMode.darken,
                                                errorBuilder: (_, __, ___) =>
                            _fallbackBackground(),
                                              ),
                        ),
                  ),
                ),
              ),

              // Blur overlay for readability
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: Container(
                    color: Colors.black.withOpacity(0.12),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Eye icon
                    if (isShowEye)
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.visibility,
                              color: Colors.white),
                          onPressed: () =>
                              _openPreview(widget.item['image']!),
                        ),
                      ),

                    const Spacer(),

                    Text(
                      widget.item['title'] ?? "",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      widget.item['subtitle'] ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fallbackBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade200,
            Colors.grey.shade100,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}

// ================= IMAGE PREVIEW DIALOG =================
class _ImagePreviewDialog extends StatelessWidget {
  final String imagePath;

  const _ImagePreviewDialog({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.broken_image, size: 80),
            ),
          ),
        ),
      ],
    );
  }
}


// ---------- CERTIFICATIONS DATA ----------
final List<Map<String, dynamic>> certificationsData = [
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
final List<Map<String, dynamic>> achievementsData = [
  {
    "title": "5 Stars in Java",
    "subtitle": "HackerRank Competitive Programming",
    "image": "assets/certifications/java_hackerrank_certi.png"
  },
  {
    "title": "Executive Member",
    "subtitle": "CodeChef SSIU Chapter",
    "isShowEye": false,
    "image": "assets/certifications/executive_member.png"
  },
  {
    "title": "Evaluator — Internal Hackathon",
    "subtitle": "SSIU Gandhinagar",
    "isShowEye": false,
    "image": "assets/certifications/internal_hackathon.png"
  },
];

