import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_constants.dart';
import '../theme/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String hintText;
  final Color borderColor;
  final Color backgroundColor;
  final int? maxLines;
  final bool isPassword;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.label,
    required this.hintText,
    this.maxLines = 1,
    this.borderColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = AppConstants.screenWidth(context);

    final textSize = AppConstants.getDescriptionFontSize(screenWidth);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = AppConstants.isMobileView(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label != ""
                ? Text(
                    label ?? "",
                    style: GoogleFonts.instrumentSans(
                      fontSize: textSize,
                      fontWeight: FontWeight.w100,
                      color: AppColors.primary,
                      wordSpacing: 2,
                    ),
                  )
                : SizedBox.shrink(),
            const SizedBox(height: 6),
            TextFormField(
              cursorHeight: isMobile ? 10 : 20,
              style: GoogleFonts.instrumentSans(
                fontSize: textSize,
                fontWeight: FontWeight.w100,
                color: AppColors.primary,
                wordSpacing: 2,
              ),
              maxLines: maxLines,
              cursorColor: AppColors.primary,
              controller: controller,
              obscureText: isPassword,
              keyboardType: keyboardType,
              validator: validator,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: isMobile ? 12 : 15, horizontal: 12),
                  filled: true,
                  fillColor: backgroundColor,
                  hintText: hintText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: borderColor, width: 1)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: borderColor, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red.shade500),
                  ),
                  hintStyle: GoogleFonts.instrumentSans(
                    fontSize: textSize,
                    fontWeight: FontWeight.w100,
                    color: AppColors.grey,
                    wordSpacing: 2,
                  ),
                  focusColor: AppColors.primary),
            ),
          ],
        );
      },
    );
  }
}
