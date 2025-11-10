import 'package:flutter/material.dart';
import 'package:mohit_portfolio/screens/services/service_screen.dart';
import 'package:mohit_portfolio/screens/work/featured_works.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/colors.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/base_widget.dart';
import '../view_model/home_view_model.dart';
import 'contact_info/contact_info.dart';
import 'hero/hero.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: HomeViewModel(),
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = AppConstants.isMobileView(context);
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        HeroSection(key: model.introKey),
                        ServiceScreen(
                          key: model.servicesKey,
                          model: model,
                        ),
                        FeaturedWorks(
                          key: model.featureWorkKey,
                          model: model,
                        ),
                        ContactInfo(
                          key: model.contactKey,
                          model: model,
                        ),
                      ],
                    ),
                  ),
                  AppBarCustom(isMobile: isMobile, model: model),
                  if (isMobile)
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        icon: Icon(
                          model.isMenuOpen ? Icons.close : Icons.menu,
                          color: model.isMenuOpen
                              ? AppColors.primary
                              : AppColors.greyBlack,
                        ),
                        onPressed: () {
                          model.isMenuOpen = !model.isMenuOpen;
                          model.updateState();
                        },
                      ),
                    )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
