import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/colors.dart';
import 'hover_scroll_card.dart';

class ServiceCard extends StatefulWidget {
  final String description;
  final List<String> tags;
  final List<String> images;
  final Color backgroundColor;
  final Color backgroundHoverColor;
  final Color tileColor;
  final Color borderColor;
  final bool highlight;
  final List<Widget> children;

  const ServiceCard({
    super.key,
    required this.description,
    required this.tags,
    required this.images,
    required this.backgroundColor,
    required this.backgroundHoverColor,
    required this.tileColor,
    required this.borderColor,
    required this.children,
    this.highlight = false,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  final HoverScrollCardVerticalController _hoverController =
      HoverScrollCardVerticalController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        final titleFontSize = AppConstants.getTitleFontSize(screenWidth);
        final descriptionFontSize =
            AppConstants.getDescriptionFontSize(screenWidth);
        final tagFontSize = AppConstants.getTagFontSize(screenWidth);
        final cardWidth = AppConstants.getCardWidth(screenWidth);
        final imageSize = cardWidth / 4;
        final cardHeight = AppConstants.getCardHeight(screenWidth);
        final padding = AppConstants.getPadding(screenWidth);
        final spacing = AppConstants.getSpacing(screenWidth);

        return Container(
          width: cardWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.borderColor),
          child: Padding(
            padding: EdgeInsets.all(spacing),
            child: Column(
              spacing: 5,
              children: [
                HoverScrollCardVertical(
                  backgroundColor: widget.tileColor,
                  controller: _hoverController,
                  width: cardWidth,
                  children: widget.children,
                ),
                _buildHoverableCard(
                  width: cardWidth,
                  height: cardHeight,
                  padding: padding,
                  spacing: spacing,
                  imageSize: imageSize,
                  textColor:
                      widget.highlight ? AppColors.white : AppColors.black,
                  titleFontSize: titleFontSize,
                  descriptionFontSize: descriptionFontSize,
                  tagFontSize: tagFontSize,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHoverableCard({
    required double width,
    required double height,
    required double padding,
    required double spacing,
    required double imageSize,
    required Color textColor,
    required double titleFontSize,
    required double descriptionFontSize,
    required double tagFontSize,
  }) {
    double tagFontSize = width < 400 ? 10 : 12;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.triggerScrollToBottom();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.triggerScrollToTop();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: width,
            height: height,
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                      )
                    ]
                  : [],
            ),
            child: Column(
              spacing: spacing,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor.withOpacity(0.85),
                  ),
                ),
                Wrap(
                  spacing: 6,
                  children: widget.images
                      .map((img) => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              img,
                              width: imageSize,
                              height: imageSize,
                              fit: BoxFit.cover,
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: spacing),
                Flexible(
                  flex: 1,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.tags
                        .map((tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: widget.highlight
                                    ? Colors.white.withOpacity(0.15)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: tagFontSize,
                                  color: textColor,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          // Hover effect layer
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:
                  _isHovered ? widget.backgroundHoverColor : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
