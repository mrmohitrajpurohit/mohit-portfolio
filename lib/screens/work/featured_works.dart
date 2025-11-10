import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mohit_portfolio/screens/work/project_dialogue.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/colors.dart';
import '../../view_model/home_view_model.dart';
import '../services/hover_scroll_card.dart';

class FeaturedWorks extends StatefulWidget {
  final HomeViewModel model;

  const FeaturedWorks({super.key, required this.model});

  @override
  State<FeaturedWorks> createState() => _FeaturedWorksState();
}

class _FeaturedWorksState extends State<FeaturedWorks> {
  final HoverScrollCardVerticalController _hoverController =
      HoverScrollCardVerticalController();

  /// Store hover state for each grid item
  final List<bool> _hoverStates = [];

  @override
  void initState() {
    super.initState();
    _hoverStates
        .addAll(List.generate(widget.model.projectData.length, (_) => false));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isMobile = AppConstants.isMobileView(context);
        final isTablet = AppConstants.isTabletView(context);
        final spacing = AppConstants.getPadding(screenWidth);
        final devicePadding = AppConstants.getDevicePadding(screenWidth);

        return Container(
          margin: EdgeInsets.symmetric(horizontal: devicePadding, vertical: 75),
          width: constraints.maxWidth,
          color: AppColors.primary,
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Featured works",
                style: GoogleFonts.instrumentSans(
                  fontSize: AppConstants.getPageNameFontSize(screenWidth),
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey,
                  wordSpacing: 2,
                  letterSpacing: 1,
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.model.projectData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : 2,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  dynamic projectData = widget.model.projectData[index];
                  bool isHovered = _hoverStates[index];

                  return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ProjectDialog(
                          projectData: projectData, // pass object
                          screenWidth: screenWidth,
                        ),
                      );
                    },
                    child: MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          _hoverStates[index] = true;
                        });
                        _hoverController.triggerScrollToBottom();
                      },
                      onExit: (_) {
                        setState(() {
                          _hoverStates[index] = false;
                        });
                        _hoverController.triggerScrollToTop();
                      },
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: isHovered
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: AppColors.white,
                                child: Image.asset(
                                  projectData["relevantImages"][0],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          // Hover overlay
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isHovered
                                  ? Colors.black.withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: isHovered ? 1.0 : 0.7,
                                child: Text(
                                  projectData["title"],
                                  style: isHovered
                                      ? GoogleFonts.instrumentSans(
                                          fontSize:
                                              AppConstants.getPageNameFontSize(
                                                  screenWidth),
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                          wordSpacing: 2,
                                          shadows: [
                                            Shadow(
                                              offset: const Offset(4.0, 2.0),
                                              blurRadius: 15.0,
                                              color: AppColors.primary,
                                            ),
                                          ],
                                        )
                                      : TextStyle(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                          // Title on hover
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
