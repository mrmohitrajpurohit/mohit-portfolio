import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mohit_portfolio/core/utils/validators.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
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
    final colors = AppColors.of(context);
    final textStyles = AppTextStyles.of(context);
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
                horizontal: isMobile ? 12 : spacing * 10, vertical: spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Ready to create something amazing? ",
                  textAlign: TextAlign.center,
                  style: textStyles.skillsSectionTitle(isMobile),
                ),

                const SizedBox(height: 10),

                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Text(
                    "let’s talk!",
                    textAlign: TextAlign.center,
                    style: textStyles.skillsSectionDesc(isMobile),
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
                        height: cardHeight,
                    appColors: colors),
                    _callCard(
                        width: isMobile ? 400 : cardWidth, height: cardHeight, colors: colors),
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

  Widget _contactFormCard({
    required double height,
    required double width,
    required ContactInfoViewModel model,
    required AppColors appColors,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: appColors.contactCardGradient,
          ),
        ),
        child: Form(
          key: model.formKey,
          child: Column(
            spacing: 20,
            children: [
              CustomTextFormField(
                label: "Name",
                controller: model.nameController,
                backgroundColor: appColors.contactFieldBackground,
                borderColor: appColors.contactFieldBorder,
                inputTextColor: appColors.contactFieldText,
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
                backgroundColor: appColors.contactFieldBackground,
                borderColor: appColors.contactFieldBorder,
                inputTextColor: appColors.contactFieldText,
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
                backgroundColor: appColors.contactFieldBackground,
                borderColor: appColors.contactFieldBorder,
                inputTextColor: appColors.contactFieldText,
                hintText: 'Enter your message',
                validator: (value) {
                  if (value == null || !value.isValidMessage) {
                    return "Please enter a valid message";
                  }
                  return null;
                },
              ),
              GradientHoverButton(
                width: double.infinity,
                gradientColors: appColors.contactButtonGradient,
                label: "Submit",
                onPressed: () {
                  model.submitForm();
                },
                isForDark: appColors.isDark,
                model: widget.model,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _callCard({required double height, required double width, required AppColors colors}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colors.certSectionBackground,
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
                    child: Image.network(
                      "${AppConstants().configConstants.imageBaseUrl}assets/services_cards/app_development3.png",
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
                      color: colors.textPrimary,
                    ),
                  ),
                  TextSpan(
                    text:
                        "Let’s hop on a call and explore the best way to bring your ideas to life",
                    style: GoogleFonts.instrumentSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: colors.textPrimary.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: colors.textPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child:  Text("approximately 15 minutes", style: TextStyle(color: colors.primary),),
            ),
            CommonButton(
              width: double.infinity,
              buttonBackColor: Colors.transparent,
              containerBorder: Border.all(color: colors.textPrimary),
              label: "Chat on WhatsApp",
              iconWidget: Image.network(
                "${AppConstants().configConstants.imageBaseUrl}assets/icons/whatapp_icon.png",
                width: 20,
                height: 20,
              ),
              onPressed: () async {
                final Uri url = Uri.parse(
                    'https://wa.me/919982111105?text=Hello%20Mohit%20%F0%9F%91%8B%0A'
                        'I%20came%20across%20your%20portfolio%20and%20would%20like%20to%20connect%20regarding%20a%20potential%20opportunity.%0A'
                        'Looking%20forward%20to%20discussing%20further.'
                );
                if (!await launchUrl(
                  url,
                  mode: LaunchMode.platformDefault,
                  webOnlyWindowName: '_blank', // 👈 opens in new tab
                )) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
