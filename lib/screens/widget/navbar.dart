import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:mohit_portfolio/core/theme/app_colors.dart';
import 'package:mohit_portfolio/core/theme/app_text_styles.dart';

class NavBar extends StatefulWidget {
  final VoidCallback onHome;
  final VoidCallback onAbout;
  final VoidCallback onProjects;
  final VoidCallback onAIWork;
  final VoidCallback onSkills;
  final VoidCallback onAchievement;
  final VoidCallback onContact;

  const NavBar({
    super.key,
    required this.onHome,
    required this.onAbout,
    required this.onProjects,
    required this.onAIWork,
    required this.onSkills,
    required this.onAchievement,
    required this.onContact,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final PageController _pageController = PageController(
    viewportFraction: 0.55,
  );

  final List<_NavItem> _items = [];

  final List<String> _resumeImages = const [
    'https://raw.githubusercontent.com/mrmohitrajpurohit/mohit-portfolio/main/resume-image-1.jpg',
    'https://raw.githubusercontent.com/mrmohitrajpurohit/mohit-portfolio/main/resume-image-2.jpg',
  ];

  @override
  void initState() {
    super.initState();

    _items.addAll([
      _NavItem("Home", widget.onHome),
      _NavItem("Projects", widget.onProjects),
      _NavItem("AI Work", widget.onAIWork),
      _NavItem("Achievements", widget.onAchievement),
      _NavItem("Skills", widget.onSkills),
      _NavItem("Contact", widget.onContact),
    ]);
  }

  void _openResumePreview(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _ResumePreviewDialog(
        images: _resumeImages,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textStyles = AppTextStyles.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 800;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 20,
                vertical: isMobile ? 10 : 20,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 40,
                vertical: isMobile ? 14 : 16,
              ),
              decoration: BoxDecoration(
                color: colors.navbarBackground,
                borderRadius: BorderRadius.circular(14),
                boxShadow: colors.navbarShadow,
              ),
              child: isMobile
                  ? _mobileNav(colors, textStyles)
                  : _desktopNav(colors, textStyles),
            ),
          ],
        );
      },
    );
  }

  Widget _desktopNav(
    AppColors colors,
    AppTextStyles textStyles,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Mohit Rajpurohit",
          style: textStyles.navTitle,
        ),
        Row(
          children: [
            _navButton(
              "Home",
              widget.onHome,
              textStyles,
            ),
            _navButton(
              "Projects",
              widget.onProjects,
              textStyles,
            ),
            _navButton(
              "AI Work",
              widget.onAIWork,
              textStyles,
            ),
            _navButton(
              "Achievements",
              widget.onAchievement,
              textStyles,
            ),
            _navButton(
              "Skills",
              widget.onSkills,
              textStyles,
            ),
            _navButton(
              "Contact",
              widget.onContact,
              textStyles,
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _openResumePreview(context),
              icon: const Icon(
                Icons.visibility_outlined,
              ),
              color: colors.textPrimary,
              tooltip: 'View resume images',
            ),
          ],
        ),
      ],
    );
  }

  Widget _mobileNav(
    AppColors colors,
    AppTextStyles textStyles,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mohit",
                  style: textStyles.navTitleMobile,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 36,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _items.length,
                  onPageChanged: (index) {
                    _items[index].onTap();
                  },
                  itemBuilder: (_, index) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: colors.navbarBorder,
                          ),
                        ),
                        child: Text(
                          _items[index].label,
                          style: textStyles.navItemMobile,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => _openResumePreview(context),
          icon: const Icon(
            Icons.visibility_outlined,
          ),
          color: colors.textPrimary,
          tooltip: 'View resume images',
        ),
      ],
    );
  }

  Widget _navButton(
    String label,
    VoidCallback onTap,
    AppTextStyles textStyles,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Text(
          label,
          style: textStyles.navItem,
        ),
      ),
    );
  }
}

// ============================================================
// RESUME PREVIEW DIALOG
// ============================================================

class _ResumePreviewDialog extends StatefulWidget {
  final List<String> images;

  const _ResumePreviewDialog({
    required this.images,
  });

  @override
  State<_ResumePreviewDialog> createState() => _ResumePreviewDialogState();
}

class _ResumePreviewDialogState extends State<_ResumePreviewDialog> {
  late int _currentIndex;

  double _zoom = 1.0;

  final TransformationController _transformationController =
      TransformationController();

  // Default portrait ratio.
  // This is only used until the actual image dimensions are loaded.
  double _imageAspectRatio = 0.707;

  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;

    _transformationController.value = Matrix4.identity();

    _loadImageDimensions();
  }

  // ------------------------------------------------------------
  // Load actual image dimensions so the dialog can match
  // the image aspect ratio.
  // ------------------------------------------------------------

  void _loadImageDimensions() {
    _removeImageListener();

    final ImageProvider provider = NetworkImage(widget.images[_currentIndex]);

    final ImageStream stream = provider.resolve(
      const ImageConfiguration(),
    );

    final ImageStreamListener listener = ImageStreamListener(
      (ImageInfo imageInfo, bool synchronousCall) {
        final int width = imageInfo.image.width;
        final int height = imageInfo.image.height;

        if (width <= 0 || height <= 0) {
          return;
        }

        final double aspectRatio = width / height;

        if (!mounted) {
          return;
        }

        if ((_imageAspectRatio - aspectRatio).abs() > 0.001) {
          setState(() {
            _imageAspectRatio = aspectRatio;
          });
        }
      },
      onError: (Object error, StackTrace? stackTrace) {
        // Keep the default portrait ratio if the image
        // dimensions cannot be resolved.
      },
    );

    _imageStream = stream;
    _imageStreamListener = listener;

    stream.addListener(listener);
  }

  void _removeImageListener() {
    if (_imageStream != null && _imageStreamListener != null) {
      _imageStream!.removeListener(
        _imageStreamListener!,
      );
    }

    _imageStream = null;
    _imageStreamListener = null;
  }

  // ------------------------------------------------------------
  // Reset zoom and position
  // ------------------------------------------------------------

  void _resetTransformation() {
    _zoom = 1.0;

    _transformationController.value = Matrix4.identity();
  }

  // ------------------------------------------------------------
  // Change image
  // ------------------------------------------------------------

  void _previousImage() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + widget.images.length) % widget.images.length;

      _resetTransformation();
      _loadImageDimensions();
    });
  }

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.images.length;

      _resetTransformation();
      _loadImageDimensions();
    });
  }

  // ------------------------------------------------------------
  // Zoom from the CENTER of the dialog
  // ------------------------------------------------------------

  void _zoomIn() {
    final double newZoom = (_zoom + 0.25).clamp(1.0, 2.5);

    _applyCenteredZoom(newZoom);
  }

  void _zoomOut() {
    final double newZoom = (_zoom - 0.25).clamp(1.0, 2.5);

    _applyCenteredZoom(newZoom);
  }

  void _applyCenteredZoom(double newZoom) {
    setState(() {
      _zoom = newZoom;

      /*
       * Scaling around the center instead of the top-left
       * transformation origin.
       *
       * The InteractiveViewer viewport is centered, so the
       * translation below keeps the image visually centered
       * while zooming.
       */
      _transformationController.value = Matrix4.identity()
        ..translate(
          0.5 * (1.0 - newZoom),
          0.5 * (1.0 - newZoom),
        )
        ..scale(newZoom);
    });
  }

  // ------------------------------------------------------------
  // Build
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final Size screenSize = MediaQuery.of(context).size;

    /*
     * Keep the dialog within 90% of the available screen.
     *
     * The important difference from the old implementation:
     * we calculate BOTH width and height from the actual image
     * aspect ratio.
     */

    const double screenPercentage = 0.90;

    final double maxDialogWidth = screenSize.width * screenPercentage;

    final double maxDialogHeight = screenSize.height * screenPercentage;

    double dialogWidth = maxDialogWidth;

    double dialogHeight = dialogWidth / _imageAspectRatio;

    /*
     * If the calculated height is too large,
     * reduce the width so the entire dialog fits.
     */
    if (dialogHeight > maxDialogHeight) {
      dialogHeight = maxDialogHeight;

      dialogWidth = dialogHeight * _imageAspectRatio;
    }

    return Dialog(
      insetPadding: const EdgeInsets.all(8),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              color: colors.certDialogBackground,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                // ==================================================
                // IMAGE + ZOOM / PAN
                // ==================================================

                Positioned.fill(
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    minScale: 1.0,
                    maxScale: 2.5,
                    panEnabled: true,
                    scaleEnabled: true,

                    /*
                     * Give the user enough room to pan around
                     * when the resume is zoomed.
                     */
                    boundaryMargin: const EdgeInsets.all(200),

                    /*
                     * Keep the image clipped inside the dialog.
                     */
                    clipBehavior: Clip.hardEdge,

                    /*
                     * Prevent InteractiveViewer from changing
                     * the natural layout size of the image.
                     */
                    constrained: true,
                    child: SizedBox(
                      width: dialogWidth,
                      height: dialogHeight,
                      child: Image.network(
                        widget.images[_currentIndex],

                        /*
                         * The dialog itself already has the exact
                         * image aspect ratio, so we don't need
                         * BoxFit.contain creating extra space.
                         */
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                        loadingBuilder: (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }

                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 80,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // ==================================================
                // CLOSE BUTTON
                // ==================================================

                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.certDialogBackground.withOpacity(0.82),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                      color: colors.textPrimary,
                      tooltip: 'Close',
                    ),
                  ),
                ),

                // ==================================================
                // BOTTOM CONTROLS
                // ==================================================

                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colors.certDialogBackground.withOpacity(0.86),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ------------------------------------------
                          // PREVIOUS
                          // ------------------------------------------

                          IconButton(
                            onPressed: _previousImage,
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                            ),
                            color: colors.textPrimary,
                            tooltip: 'Previous resume',
                          ),

                          // ------------------------------------------
                          // ZOOM OUT
                          // ------------------------------------------

                          IconButton(
                            onPressed: _zoom > 1.0 ? _zoomOut : null,
                            icon: const Icon(
                              Icons.zoom_out_rounded,
                            ),
                            color: colors.textPrimary,
                            tooltip: 'Zoom out',
                          ),

                          // ------------------------------------------
                          // ZOOM VALUE
                          // ------------------------------------------

                          Text(
                            '${_zoom.toStringAsFixed(2)}x',
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          // ------------------------------------------
                          // ZOOM IN
                          // ------------------------------------------

                          IconButton(
                            onPressed: _zoom < 2.5 ? _zoomIn : null,
                            icon: const Icon(
                              Icons.zoom_in_rounded,
                            ),
                            color: colors.textPrimary,
                            tooltip: 'Zoom in',
                          ),

                          // ------------------------------------------
                          // NEXT
                          // ------------------------------------------

                          IconButton(
                            onPressed: _nextImage,
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                            ),
                            color: colors.textPrimary,
                            tooltip: 'Next resume',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeImageListener();

    _transformationController.dispose();

    super.dispose();
  }
}

// ============================================================
// MODEL
// ============================================================

class _NavItem {
  final String label;
  final VoidCallback onTap;

  _NavItem(
    this.label,
    this.onTap,
  );
}
