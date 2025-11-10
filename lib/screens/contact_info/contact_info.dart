import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mohit_portfolio/core/utils/validators.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/base_widget.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/gradient_hover_button.dart';
import '../../core/widgets/text_field_widget.dart';
import '../../view_model/contact_info_view_model.dart';
import '../../view_model/home_view_model.dart';

class ContactInfo extends StatefulWidget {
  final HomeViewModel model;

  const ContactInfo({super.key, required this.model});

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: ContactInfoViewModel(),
      builder: (context, model, child) {
        return LayoutBuilder(builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final isMobile = AppConstants.isMobileView(context);
          final cardHeight = AppConstants.getCardHeight(screenWidth);
          final cardWidth = AppConstants.getCardWidth(screenWidth);
          final spacing = AppConstants.getPadding(screenWidth);
          final textFontSize = AppConstants.getInfoFontSize(screenWidth);

          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: isMobile ? 50 : spacing * 10, vertical: spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Ready to create something amazing? ',
                        style: GoogleFonts.instrumentSans(
                          fontSize: textFontSize,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                        ),
                      ),
                      TextSpan(
                        text: 'let’s talk!',
                        style: GoogleFonts.instrumentSans(
                          fontSize: textFontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  alignment: WrapAlignment.start,
                  children: [
                    _contactFormCard(
                        model: model,
                        width: isMobile ? 400 : cardWidth,
                        height: cardHeight),
                    _callCard(
                        width: isMobile ? 400 : cardWidth, height: cardHeight),
                    // right box
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Widget _contactFormCard(
      {required double height,
      required double width,
      required ContactInfoViewModel model}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.greyBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: model.formKey,
          child: Column(
            spacing: 20,
            children: [
              CustomTextFormField(
                label: "Name",
                controller: model.nameController,
                backgroundColor: AppColors.darkGrey,
                borderColor: AppColors.lightGrey,
                hintText: 'Jane Smith',
                validator: (value) {
                  if (value == null || !value.isValidName) {
                    return "Please enter a valid name";
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                label: "Email",
                controller: model.emailController,
                backgroundColor: AppColors.darkGrey,
                borderColor: AppColors.lightGrey,
                hintText: 'yourname@gmail.com',
                validator: (value) {
                  if (value == null || !value.isValidEmail) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                label: "Your Message",
                controller: model.messageController,
                maxLines: 6,
                backgroundColor: AppColors.darkGrey,
                borderColor: AppColors.lightGrey,
                hintText: 'Enter your message',
                validator: (value) {
                  if (value == null || !value.isValidMessage) {
                    return "Please enter a valid message";
                  }
                  return null;
                },
              ),
              GradientHoverButton(
                isForDark: true,
                width: double.infinity,
                gradientColors: [AppColors.primary, AppColors.primary],
                label: "Submit",
                onPressed: () {
                  model.submitForm();
                },
                model: widget.model,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _callCard({required double height, required double width}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                    color: Colors.red,
                    child: Image.asset(
                      "assets/services_cards/app_development3.png",
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ))),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Prefer a quick chat? ",
                    style: GoogleFonts.instrumentSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text:
                        "Let’s hop on a call and explore the best way to bring your ideas to life",
                    style: GoogleFonts.instrumentSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text("approximately 15 minutes"),
            ),
            CommonButton(
              width: double.infinity,
              buttonBackColor: Colors.transparent,
              containerBorder: Border.all(color: AppColors.grey),
              label: "Book a Call",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
