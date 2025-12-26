import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;

    final colors = AppColors.of(context);
    final textStyles = AppTextStyles.of(context);

    final List<Map<String, dynamic>> allItems = [
      ...certificationsData,
      ...achievementsData,
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 60,
        vertical: isMobile ? 60 : 90,
      ),
      color: colors.certSectionBackground,
      child: Column(
        children: [
          Text(
            "Certifications & Achievements",
            textAlign: TextAlign.center,
            style: textStyles.certSectionTitle(isMobile),
          ),

          const SizedBox(height: 12),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Text(
              "Verified certifications, recognitions, and milestones that reflect my learning journey and professional growth.",
              textAlign: TextAlign.center,
              style: textStyles.certSectionDesc(isMobile),
            ),
          ),

          SizedBox(height: isMobile ? 36 : 60),

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
                crossAxisSpacing: isMobile ? 16 : 28,
                mainAxisSpacing: isMobile ? 16 : 28,
                childAspectRatio: count == 1 ? 1.05 : 1.3,
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
    final bool isMobile = MediaQuery.of(context).size.width < 700;
    final bool isShowEye = widget.item['isShowEye'] ?? true;
    final String? imagePath = widget.item['image'];

    final colors = AppColors.of(context);
    final textStyles = AppTextStyles.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: colors.certCardShadow,
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              // ================= BACKGROUND =================
              Positioned.fill(
                child: imagePath != null && imagePath.isNotEmpty
                    ? Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  color: colors.certImageOverlay,
                  colorBlendMode: BlendMode.darken,
                  errorBuilder: (_, __, ___) =>
                      _fallbackBackground(colors),
                )
                    : _fallbackBackground(colors),
              ),

              // ================= BLUR =================
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: Container(
                    color: colors.certBlurOverlay,
                  ),
                ),
              ),

              // ================= CONTENT =================
              Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isShowEye &&
                        imagePath != null &&
                        imagePath.isNotEmpty)
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () => _openPreview(imagePath),
                        ),
                      ),

                    const Spacer(),

                    Text(
                      widget.item['title'] ?? "",
                      style: textStyles.certCardTitle(isMobile),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      widget.item['subtitle'] ?? "",
                      style: textStyles.certCardSubtitle(isMobile),
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

  Widget _fallbackBackground(AppColors colors) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.certFallbackStart,
            colors.certFallbackEnd,
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
    final colors = AppColors.of(context);

    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(color: colors.certDialogBackdrop),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.certDialogBackground,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Image.network(
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

// ---------- DATA ----------
final List<Map<String, dynamic>> certificationsData = [
  {
    "title": "Oracle Certified Foundation Associate",
    "subtitle": "Oracle • Jan 2022",
    "image":
    "${AppConstants().configConstants.imageBaseUrl}assets/certifications/oracle_foundation.png"
  },
  {
    "title": "Android Webinar Participation",
    "subtitle": "May 2020",
    "image":
    "${AppConstants().configConstants.imageBaseUrl}assets/certifications/android_webinar.png"
  },
  {
    "title": "Internal Hackathon Evaluation",
    "subtitle": "SSIU • March 2022",
    "image":
    "${AppConstants().configConstants.imageBaseUrl}assets/certifications/hackathon_eval.png"
  },
  {
    "title": "AWS Billing & Cost Management",
    "subtitle": "AWS • Apr 2022",
    "image":
    "${AppConstants().configConstants.imageBaseUrl}assets/certifications/aws_billing.png"
  },
  {
    "title": "Java Programming Certificate",
    "subtitle": "Great Learning • Oct 2021",
    "image":
    "${AppConstants().configConstants.imageBaseUrl}assets/certifications/java_great_learning.png"
  },
  {
    "title": "CodeChef Go Code Participation",
    "subtitle": "Feb 2022",
    "image":
    "${AppConstants().configConstants.imageBaseUrl}assets/certifications/codechef_go_code.png"
  },
  {
    "title": "MSME Entrepreneurship Program",
    "subtitle": "Nov 2021",
    "image":
    "${AppConstants().configConstants.imageBaseUrl}assets/certifications/msme_program.png"
  },
];

final List<Map<String, dynamic>> achievementsData = [
  {
    "title": "5 Stars in Java",
    "subtitle": "HackerRank Competitive Programming",
    "image":
    "${AppConstants().configConstants.imageBaseUrl}assets/certifications/java_hackerrank_certi.png"
  },
  {
    "title": "Executive Member",
    "subtitle": "CodeChef SSIU Chapter",
    "isShowEye": false,
    "image":
    "${AppConstants().configConstants.imageBaseUrl}assets/certifications/executive_member.png"
  },
  {
    "title": "Evaluator — Internal Hackathon",
    "subtitle": "SSIU Gandhinagar",
    "isShowEye": false,
    "image":
    "${AppConstants().configConstants.imageBaseUrl}assets/certifications/internal_hackathon.png"
  },
];
