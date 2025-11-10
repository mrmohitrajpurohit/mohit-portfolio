// lib/viewmodels/portfolio_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/project_model.dart';

class PortfolioViewModel extends ChangeNotifier {
  final List<ProjectModel> _projects = [
    ProjectModel(
      title: "NewsSync",
      description: "A modern news platform.",
      imageUrl: "images/news.png",
      link: "https://example.com",
    ),
    // Add more...
  ];

  List<ProjectModel> get projects => _projects;
}
