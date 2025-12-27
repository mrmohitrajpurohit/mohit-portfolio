import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/web.dart' as web;

import '../../view_model/home_view_model.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import 'gradient_hover_button.dart';

class AppBarCustom extends StatelessWidget {
  final bool isMobile;
  final HomeViewModel model;

  const AppBarCustom({super.key, required this.isMobile, required this.model});

  void downloadResume() {
    final url =
        'https://raw.githubusercontent.com/DhruvikPrj/my_resume/main/dhruvik_resume.pdf';

    final anchor = web.HTMLAnchorElement()
      ..href = url
      ..download = 'Dhruvik_Resume.pdf'
      ..target = '_blank'
      ..style.display = 'none';

    web.document.body!.append(anchor);
    anchor.click();
    anchor.remove();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.of(context);
    return isMobile
        ? AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, -0.1), // slide from top
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: model.isMenuOpen
                ? buildMobileMenu(
                    model: model,
                    context: context,
                    key: ValueKey('menu')) // must use a key
                : SizedBox.shrink(key: ValueKey('empty')),
          )
        : buildDesktopMenu(model: model, appColors: appColors);
  }

  Widget buildDesktopMenu({required HomeViewModel model, required AppColors appColors}) {
    return Container(
      color: appColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          InkWell(
            onTap: () => model.scrollToSection(model.introKey),
            child: Text("Dhruvik Prajapati",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Spacer(),
          buildNavItem(
              text: "About",
              onTap: () {
                model.scrollToSection(model.introKey);
                model.updateState();
              },
              isMobile: false,
              appColors: appColors,
              model: model),
          buildNavItem(
              text: "Services",
              onTap: () => model.scrollToSection(model.servicesKey),
              isMobile: false,
              appColors: appColors,
              model: model),
          buildNavItem(
              text: "Work",
              onTap: () => model.scrollToSection(model.featureWorkKey),
              isMobile: false,
              appColors: appColors,
              model: model),
          buildNavItem(
              text: "Contact",
              onTap: () => model.scrollToSection(model.contactKey),
              isMobile: false,
              appColors: appColors,
              model: model),
          Spacer(),
          GradientHoverButton(
            isForDark: false,
            gradientColors: [appColors.black, appColors.black],
            label: "Download Resume",
            onPressed: () {
              downloadResume();
            },
            icon: Icons.arrow_forward_ios_rounded,
            model: model,
          ),
        ],
      ),
    );
  }

  Widget buildMobileMenu(
      {Key? key, required BuildContext context, required HomeViewModel model}) {
    final appColors = AppColors.of(context);
    return Container(
      width: AppConstants.screenWidth(context),
      key: key,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: appColors.greyBlack,
      ),
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Text(
            "Dhruvik Prajapati",
            style: GoogleFonts.instrumentSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: appColors.primary,
              wordSpacing: 2,
            ),
          ),
          buildNavItem(
              text: "About",
              onTap: () => model.scrollToSection(model.introKey),
              isMobile: true,
              appColors: appColors,
              model: model),
          buildNavItem(
              text: "Services",
              onTap: () => model.scrollToSection(model.servicesKey),
              isMobile: true,
              appColors: appColors,
              model: model),
          buildNavItem(
              text: "Work",
              onTap: () => model.scrollToSection(model.featureWorkKey),
              isMobile: true,
              appColors: appColors,
              model: model),
          buildNavItem(
              text: "Contact",
              onTap: () => model.scrollToSection(model.contactKey),
              isMobile: true,
              appColors: appColors,
              model: model),
          GradientHoverButton(
            isForDark: true,
            gradientColors: [appColors.primary, appColors.primary],
            label: "Download Resume",
            onPressed: () {
              downloadResume();
            },
            // textStyle: GoogleFonts.instrumentSans(
            //   fontSize: 12,
            //   fontWeight: FontWeight.w500,
            //   wordSpacing: 2,
            // ),
            icon: Icons.arrow_forward_ios_rounded,
            model: model,
          ),
        ],
      ),
    );
  }

  Widget buildNavItem(
      {required String text,
      required VoidCallback onTap,
      required bool isMobile,
      required HomeViewModel model, required AppColors appColors}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        focusColor: Colors.transparent,
        autofocus: false,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Text(
          text,
          style: GoogleFonts.instrumentSans(
            fontSize: isMobile && model.isMenuOpen ? 12 : 18,
            fontWeight: FontWeight.w500,
            color: isMobile && model.isMenuOpen
                ? appColors.primary
                : appColors.greyBlack,
            wordSpacing: 2,
          ),
        ),
      ),
    );
  }
}
