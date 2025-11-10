import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  bool isMenuOpen = false;

  bool isHovered = false;

  GlobalKey introKey = GlobalKey();
  GlobalKey servicesKey = GlobalKey();
  GlobalKey contactKey = GlobalKey();
  GlobalKey featureWorkKey = GlobalKey();

  List<String> sections = ['About', 'Services', 'Work', 'Contact'];

  void scrollToSection(GlobalKey key) async {
    final context = key.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      closeMenuWithAnimation();
    } else {}
  }

  void closeMenuWithAnimation() {
    if (!isMenuOpen) return;

    isMenuOpen = false;
    notifyListeners();
  }

  void updateState() {
    notifyListeners();
  }

  List serviceData = [
    {
      "title": "UI/UX Development",
      "description":
          "I design intuitive and user-friendly interfaces for mobile apps. My process focuses on accessibility, visual hierarchy, and seamless user flow to ensure better engagement.",
      "tags": ["UI", "User flow", "App mockups", "Design systems", "+more"],
      "relevantImages": [
        "assets/services_cards/ui_ux.jpg",
        "assets/services_cards/ui_ux1.jpg",
        "assets/services_cards/ui_ux2.png",
      ],
      "icon": Icons.splitscreen
    },
    {
      "title": "App Development",
      "description":
          "I craft high-performance, cross-platform mobile apps using Flutter. From prototypes to production-ready apps, I deliver fast, beautiful, and scalable solutions for Android, iOS, and web.",
      "tags": [
        "Cross-platform",
        "Performance",
        "Animations",
        "Responsive UI",
        "+more"
      ],
      "relevantImages": [
        "assets/services_cards/app_development1.jpeg",
        "assets/services_cards/app_devopment.jpeg",
        "assets/services_cards/app_development3.png"
      ],
      "icon": Icons.android
    },
    {
      "title": "API Integration",
      "description":
          "I integrate RESTful and GraphQL APIs, and build robust logic to power your mobile applications — including authentication, real-time updates, and secure data handling.",
      "tags": [
        "REST & GraphQL",
        "Firebase",
        "Node.js",
        "Authentication",
        "+more"
      ],
      "relevantImages": [
        "assets/services_cards/flutter_api.jpg",
        "assets/services_cards/flutter_api1.jpg",
        "assets/services_cards/flutter_api2.jpg"
      ],
      "icon": Icons.api_rounded
    }
  ];

  List projectData = [
    {
      "title": "Deep Tech Stars",
      "description":
          "Deep Tech Stars is an AI-focused app designed to keep users updated on Machine Learning, NLP, Data Science, and other AI domains. It delivers curated content, including news, blogs, research papers, and career guidance. The app was built from scratch with features like dark/light mode, Branch.io for deep linking, and push notifications. These tools enhance user experience and ensure personalized, up-to-date learning.",
      "tags": ["Dart", "Flutter", "Firebase", "Branch.io", "Provider"],
      "relevantImages": [
        "assets/projects/dts_thumbnail.png",
        "assets/projects/dts_thumbnail.png",
        "assets/projects/dts_thumbnail.png",
        "assets/projects/dts_thumbnail.png",
      ],
      "icon": Icons.auto_awesome,
    },
    {
      "title": "Crewlair",
      "description":
          "Crewlair is a cross-platform dating app that helps users find matches, make friends, and connect through audio/video calls. Key features include one-on-one calls, the Crew group chat (up to 20 users), and the TV Room for shared video watching during group calls. Focused on implementing and optimizing video/audio call and TV Room functionalities using Agora.io. Enabled screen sharing, real-time messaging with socket programming, and seamless group communication to enhance user experience.",
      "tags": [
        "Dart",
        "Flutter",
        "Firebase",
        "Branch.io",
        "Agora.io",
        "Riverpod"
      ],
      "relevantImages": [
        "assets/projects/crewlair_thumbnail.png",
        "assets/projects/crewlair_thumbnail.png",
        "assets/projects/crewlair_thumbnail.png",
        "assets/projects/crewlair_thumbnail.png",
      ],
      "icon": Icons.people_alt_rounded,
    },
    {
      "title": "Vehya",
      "description":
          "Contributing to the development of a product and service-based platform, focusing on building scalable and efficient solutions. Collaborating with cross-functional teams to deliver high-quality features and services for end-users. Implementing end-to-end features, from concept to deployment, ensuring a seamless user experience. Built for both mobile and web platforms.",
      "tags": ["Flutter", "Firebase", "Google Maps API", "Riverpod"],
      "relevantImages": [
        "assets/projects/vehya_thumbnail.png",
        "assets/projects/vehya_thumbnail.png",
        "assets/projects/vehya_thumbnail.png",
        "assets/projects/vehya_thumbnail.png",
      ],
      "icon": Icons.api_rounded,
    },
    {
      "title": "Kurudy",
      "description":
          "Visa, Tourism & Citizenship Services Platform – Contributed to the design and development of a cross-platform React Native mobile application delivering end-to-end services across visa procurement, tour package curation, and citizenship consultation tailored for African destinations. Implemented secure document handling, user onboarding flows, real-time application tracking, and curated travel offerings, ensuring a seamless, accessible experience while collaborating closely with cross-functional teams to deliver high-quality, user-centric solutions.",
      "tags": ["React Native", "Firebase", "Redux"],
      "relevantImages": [
        "assets/projects/kurudy_thumbnail.png",
        "assets/projects/kurudy_thumbnail.png",
        "assets/projects/kurudy_thumbnail.png",
        "assets/projects/kurudy_thumbnail.png",
      ],
      "icon": Icons.flight_takeoff_rounded,
    }
  ];
}
