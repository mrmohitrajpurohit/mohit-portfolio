import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';

class CommonButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? buttonBackColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final IconData? icon;
  final Widget? iconWidget;
  final double? width;
  final bool isForDark;
  final double textSize;
  final Border? containerBorder;

  const CommonButton(
      {super.key,
        required this.label,
        required this.onPressed,
        this.buttonBackColor,
        this.textStyle,
        this.borderRadius = 12.0,
        this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        this.icon,
        this.iconWidget,
        this.width = 200,
        this.textSize = 12,
        this.containerBorder,
        this.isForDark = false});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    final screenWidth = AppConstants.screenWidth(context);

    final labelSize = AppConstants.getDescriptionFontSize(screenWidth);

    return InkWell(
      onTap: () {
        widget.onPressed();
      },
      child:Container(
        width: widget.width,
        height: 40,
        padding: widget.padding,
        decoration: BoxDecoration(
         color: widget.buttonBackColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: widget.containerBorder ?? Border.fromBorderSide(
            BorderSide(width: 1.0, color: appColors.white),
          ),
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
                    color:  appColors.textPrimary,
                    wordSpacing: 2,
                  ),
            ),
            if (widget.iconWidget != null) ...[
              widget.iconWidget!
            ],
            if (widget.icon != null) ...[
              Icon(widget.icon!,
                  color: appColors.primary,
                  size: 15),
            ],
          ],
        ),
      ),
    );
  }
}
