import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mohit_portfolio/screens/services/service_cards.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/colors.dart';
import '../../view_model/home_view_model.dart';

class ServiceScreen extends StatefulWidget {
  final HomeViewModel model;

  const ServiceScreen({super.key, required this.model});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  Widget _buildCardContent(
      {String? title,
      IconData? icon,
      VoidCallback? onIconTap,
      Color? textColor,
      Color? iconColor,
      Color? iconBgColor,
      required double screenWidth}) {
    final textFontSize = AppConstants.getTitleFontSize(screenWidth);
    final iconSize = AppConstants.getServiceCardIconSize(screenWidth);

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            style: GoogleFonts.instrumentSans(
              fontSize: textFontSize,
              fontWeight: FontWeight.w500,
              color: textColor,
              wordSpacing: 2,
            ),
            title!,
          ),
          GestureDetector(
            onTap: onIconTap,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppConstants.isMobileView(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final textFontSize = AppConstants.getInfoFontSize(screenWidth);
        final textTitleSize = AppConstants.getPageNameFontSize(screenWidth);
        final height = AppConstants.screenHeight(context);

        return Container(
          padding: EdgeInsets.symmetric(
              vertical:
                  isMobile ? 50 : MediaQuery.of(context).size.height * 0.1,
              horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: isMobile ? 50 : 100,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile
                        ? 20
                        : MediaQuery.of(context).size.width * 0.2),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Services',
                                style: GoogleFonts.instrumentSans(
                                  fontSize: textTitleSize,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey,
                                  wordSpacing: 2,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 20),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Build high-performance Flutter apps that feel native and look stunning across all platforms. ',
                                      style: GoogleFonts.instrumentSans(
                                        fontSize: textFontSize,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.grey,
                                        wordSpacing: 2,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'I craft scalable mobile solutions with precision, speed, and beautiful UI.',
                                      style: GoogleFonts.instrumentSans(
                                        fontSize: textFontSize,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        wordSpacing: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Services',
                                style: GoogleFonts.instrumentSans(
                                  fontSize: textTitleSize,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey,
                                  wordSpacing: 2,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(width: 150),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'Build high-performance Flutter apps that feel native and look stunning across all platforms. ',
                                        style: GoogleFonts.instrumentSans(
                                          fontSize: textFontSize,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.grey,
                                          wordSpacing: 2,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'I craft scalable mobile solutions with precision, speed, and beautiful UI.',
                                        style: GoogleFonts.instrumentSans(
                                          fontSize: textFontSize,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          wordSpacing: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runSpacing: isMobile ? 20 : 50,
                  spacing: isMobile ? 20 : 50,
                  children: List.generate(
                    widget.model.serviceData.length,
                    (index) {
                      dynamic data = widget.model.serviceData[index];

                      return ServiceCard(
                        description: data["description"],
                        tags: data["tags"],
                        images: data["relevantImages"],
                        highlight: index % 2 == 0 ? false : true,
                        backgroundColor: index % 2 == 0
                            ? Colors.white
                            : AppColors.hoverButtonBg,
                        tileColor: index % 2 == 0
                            ? Colors.white
                            : AppColors.hoverButtonBg,
                        borderColor: Colors.grey,
                        backgroundHoverColor: index % 2 == 0
                            ? Colors.white.withOpacity(0.7)
                            : Colors.black.withOpacity(0.5),
                        children: [
                          _buildCardContent(
                              title: data["title"],
                              icon: data["icon"],
                              onIconTap: () {
                                debugPrint("UI/UX clicked");
                              },
                              textColor: index % 2 == 0
                                  ? AppColors.black
                                  : AppColors.white,
                              iconColor: index % 2 == 0
                                  ? AppColors.accent
                                  : AppColors.hoverButtonBg,
                              iconBgColor: index % 2 == 0
                                  ? AppColors.lightAccent
                                  : AppColors.white,
                              screenWidth: screenWidth),
                          _buildCardContent(
                              title: "Start a Project",
                              icon: Icons.open_in_new,
                              onIconTap: () {},
                              textColor: index % 2 == 0
                                  ? AppColors.black
                                  : AppColors.white,
                              iconColor: index % 2 == 0
                                  ? AppColors.accent
                                  : AppColors.hoverButtonBg,
                              iconBgColor: index % 2 == 0
                                  ? AppColors.lightAccent
                                  : AppColors.white,
                              screenWidth: screenWidth),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
