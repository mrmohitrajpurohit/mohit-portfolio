import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/colors.dart';

class ProjectDialog extends StatefulWidget {
  final Map<String, dynamic> projectData;
  final double screenWidth;

  const ProjectDialog({
    super.key,
    required this.projectData,
    required this.screenWidth,
  });

  @override
  State<ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> images = widget.projectData["relevantImages"] ?? [];

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        width: widget.screenWidth * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              widget.projectData["title"] ?? "App Introduction",
              style: GoogleFonts.poppins(
                fontSize: AppConstants.getTitleFontSize(widget.screenWidth),
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Subtitle / description
            Text(
              widget.projectData["description"] ??
                  "Ducium faccum lacidit lorem ipsum dolor sit amet, consectetur.",
              style: GoogleFonts.poppins(
                fontSize: AppConstants.getDescriptionFontSize(widget.screenWidth),
                color: AppColors.black.withOpacity(0.65),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Carousel with mockup images
            if (images.isNotEmpty) ...[
              SizedBox(
                height: 350,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),

                    // Left Arrow
                    Positioned(
                      left: 0,
                      child: IconButton(
                        icon: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.6),
                          child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                        ),
                        onPressed: () {
                          if (_currentPage > 0) {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),

                    // Right Arrow
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.6),
                          child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                        ),
                        onPressed: () {
                          if (_currentPage < images.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Dot Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  final isActive = _currentPage == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary : AppColors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
              ),
            ],

            const SizedBox(height: 20),

            // Tags section
            if (widget.projectData["tags"] != null &&
                widget.projectData["tags"].isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: List.generate(
                  widget.projectData["tags"].length,
                      (tagIndex) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.hoverButtonBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.projectData["tags"][tagIndex],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
