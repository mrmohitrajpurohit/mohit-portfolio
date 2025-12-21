import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectCarouselCard extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProjectCarouselCard({super.key, required this.data});

  @override
  State<ProjectCarouselCard> createState() => _ProjectCarouselCardState();
}

class _ProjectCarouselCardState extends State<ProjectCarouselCard> {
  int _index = 0;

  Future<void> _open(String? url) async {
    if (url == null) return;
    await launchUrlString(url, webOnlyWindowName: "_blank");
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.data;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Card container
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                // Background carousel
                Positioned.fill(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1.0,
                      height: double.infinity,
                      onPageChanged: (i, r) => setState(() => _index = i),
                    ),
                    items: List.generate(project['images'].length, (i) {
                      return Image.asset(
                        project['images'][i],
                        fit: BoxFit.contain,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 50),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // Gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.45),
                          Colors.black.withOpacity(0.25),
                          Colors.black.withOpacity(0.55),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                // Content Layer
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),

                        // Title
                        Text(
                          project['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Description
                        Text(
                          project['desc'],
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Tech Tags
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          children: project['tech']
                              .map<Widget>(
                                (t) =>
                                    OutlinedButton.icon(
                                      onPressed: () =>
                                          {},
                                      label:  Text(t),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        side:
                                        const BorderSide(color: Colors.white54),
                                      ),
                                    ),
                          )
                              .toList(),
                        ),

                        const SizedBox(height: 16),

                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (project['playStore'] != null)
                              OutlinedButton.icon(
                                onPressed: () =>
                                    _open(project['playStore']),
                                icon: const Icon(Icons.android, size: 16),
                                label: const Text("Play Store"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side:
                                  const BorderSide(color: Colors.white54),
                                ),
                              ),
                            if (project['playStore'] != null)
                              const SizedBox(width: 10),

                            if (project['live'] != null)
                              OutlinedButton.icon(
                                onPressed: () => _open(project['live']),
                                icon: const Icon(Icons.open_in_new, size: 16),
                                label: const Text("Visit"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side:
                                  const BorderSide(color: Colors.white54),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Logo (floating top center)
        Positioned(
          top: -32,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  widget.data['logo'],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.ac_unit),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
