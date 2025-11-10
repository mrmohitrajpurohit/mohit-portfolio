import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../view_model/home_view_model.dart';
import '../constants/app_constants.dart';
import '../theme/colors.dart';

class GradientHoverButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final List<Color>? gradientColors;
  final List<Color>? hoverGradientColors;
  final TextStyle? textStyle;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final IconData? icon;
  final double? width;
  final bool isForDark;
  final double textSize;
  final HomeViewModel model;

  const GradientHoverButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.gradientColors,
      this.hoverGradientColors,
      this.textStyle,
      this.borderRadius = 12.0,
      this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      this.icon,
      this.width,
      this.textSize = 12,
      this.isForDark = false,
      required this.model});

  @override
  State<GradientHoverButton> createState() => _GradientHoverButtonState();
}

class _GradientHoverButtonState extends State<GradientHoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final defaultHoverGradient = [
      AppColors.hoverButtonBg,
      AppColors.hoverButtonBg
    ];
    final defaultGradient = [Colors.black, Colors.black];

    final screenWidth = AppConstants.screenWidth(context);

    final labelSize = AppConstants.getDescriptionFontSize(screenWidth);

    final gradient = _isHovered
        ? (widget.hoverGradientColors ?? defaultHoverGradient)
        : (widget.gradientColors ?? defaultGradient);

    return MouseRegion(
      onEnter: (_) {
        _isHovered = true;
        widget.model.updateState();
      },
      onExit: (_) {
        _isHovered = false;
        widget.model.updateState();
      },
      child: InkWell(
        onTap: () {
          widget.onPressed();
        },
        child: AnimatedContainer(
          width: widget.width,
          height: 40,
          duration: const Duration(milliseconds: 300),
          padding: widget.padding,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Text(
                widget.label,
                style: widget.textStyle ??
                    GoogleFonts.instrumentSans(
                      fontSize: labelSize,
                      fontWeight: FontWeight.w500,
                      color: _isHovered
                          ? AppColors.primary
                          : widget.isForDark
                              ? AppColors.greyBlack
                              : AppColors.primary,
                      wordSpacing: 2,
                    ),
              ),
              if (widget.icon != null) ...[
                Icon(widget.icon!,
                    color: _isHovered
                        ? AppColors.primary
                        : widget.isForDark
                            ? AppColors.greyBlack
                            : AppColors.primary,
                    size: 15),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
