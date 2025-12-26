import 'package:flutter/material.dart';

import '../../../data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../project_carousel_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;

    final colors = AppColors.of(context);
    final textStyles = AppTextStyles.of(context);

    return Container(
      color: colors.projectsSectionBackground,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 50 : 70,
        horizontal: isMobile ? 16 : 40,
      ),
      child: Column(
        children: [
          Text(
            "Projects",
            style: textStyles.projectsTitle,
          ),
          const SizedBox(height: 10),
          Text(
            "A combined showcase of my Web & Mobile development work — with live links and project visuals.",
            textAlign: TextAlign.center,
            style: textStyles.projectsSubtitle,
          ),
          SizedBox(height: isMobile ? 25 : 35),
          _projectsGrid(context),
        ],
      ),
    );
  }

  Widget _projectsGrid(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      int count = 1;
      double aspectRatio = 1.8;

      if (c.maxWidth > 1200) {
        count = 3;
        aspectRatio = 1.8;
      } else if (c.maxWidth > 800) {
        count = 2;
        aspectRatio = 1.6;
      } else {
        count = 1;
        aspectRatio = 1.25;
      }

      return GridView.builder(
        shrinkWrap: true,
        itemCount: mergedProjects.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count,
          mainAxisSpacing: 30,
          crossAxisSpacing: 20,
          childAspectRatio: aspectRatio,
        ),
        itemBuilder: (_, i) => ProjectCarouselCard(
          data: mergedProjects[i],
        ),
      );
    });
  }
}
