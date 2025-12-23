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
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;

    return Stack(
      clipBehavior: Clip.none,
      children: [
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
                // ================= BACKGROUND CAROUSEL =================
                Positioned.fill(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1.0,
                      height: double.infinity,
                      onPageChanged: (i, _) => setState(() => _index = i),
                    ),
                    items: List.generate(project['images'].length, (i) {
                      return Image.asset(
                        project['images'][i],
                        fit: isMobile ? BoxFit.cover : BoxFit.contain,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child:
                            Icon(Icons.image_not_supported, size: 50),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // ================= GRADIENT =================
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.55),
                          Colors.black.withOpacity(0.25),
                          Colors.black.withOpacity(0.6),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                // ================= CONTENT =================
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 22,
                      vertical: isMobile ? 12 : 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),

                        Text(
                          project['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          project['desc'],
                          textAlign: TextAlign.center,
                          maxLines: isMobile ? 4 : 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isMobile ? 13 : 14,
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 6,
                          runSpacing: 6,
                          children: project['tech']
                              .map<Widget>(
                                (t) => OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                    color: Colors.white54),
                              ),
                              child: Text(
                                t,
                                style: TextStyle(
                                    fontSize: isMobile ? 11 : 12),
                              ),
                            ),
                          )
                              .toList(),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (project['playStore'] != null)
                              OutlinedButton.icon(
                                onPressed: () =>
                                    _open(project['playStore']),
                                icon:
                                const Icon(Icons.android, size: 16),
                                label: const Text("Play Store"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(
                                      color: Colors.white54),
                                ),
                              ),
                            if (project['playStore'] != null)
                              const SizedBox(width: 8),
                            if (project['live'] != null)
                              OutlinedButton.icon(
                                onPressed: () =>
                                    _open(project['live']),
                                icon:
                                const Icon(Icons.open_in_new, size: 16),
                                label: const Text("Visit"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(
                                      color: Colors.white54),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ================= LOGO =================
        Positioned(
          top: isMobile ? -26 : -32,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: isMobile ? 55 : 65,
              width: isMobile ? 55 : 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
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
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.ac_unit),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
