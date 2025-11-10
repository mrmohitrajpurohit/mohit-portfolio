import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';
import '../utils/keys.dart';

enum ToastType { success, error, warning, info }

class ToastService {
  void show({
    required String title,
    required String message,
    required ToastType type,
    Duration duration = const Duration(seconds: 4),
  }) {
    final context = Keys.navigatorKey.currentContext;
    if (context == null) return;

    final overlay = Overlay.of(context);
    if (overlay == null) return;

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (_) => _ToastWidget(
        title: title,
        message: message,
        type: type,
        onClose: () => overlayEntry.remove(),
        duration: duration,
      ),
    );

    overlay.insert(overlayEntry);

    // Auto-remove after delay
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}

class _ToastWidget extends StatefulWidget {
  final String title;
  final String message;
  final ToastType type;
  final VoidCallback onClose;
  final Duration duration;

  const _ToastWidget({
    required this.title,
    required this.message,
    required this.type,
    required this.onClose,
    required this.duration,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _slide = Tween<Offset>(
      begin: const Offset(0, -1.0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Optional: animate out before auto-dismiss
    Future.delayed(widget.duration - const Duration(milliseconds: 300), () {
      if (mounted) _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final background = _backgroundColor(widget.type);
    final icon = _toastIcon(widget.type);
    final screenWidth = MediaQuery.of(context).size.width;

    double width = screenWidth > 600
        ? 500
        : screenWidth > 400
            ? screenWidth * 0.85
            : screenWidth * 0.95;

    return Positioned(
      top: 50,
      left: (screenWidth - width) / 2,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _slide,
          child: Container(
            width: width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row (Icon, Title, Close)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: GoogleFonts.instrumentSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          wordSpacing: 2,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _controller.reverse().then((_) => widget.onClose());
                      },
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Message
                Padding(
                  padding: const EdgeInsets.only(left: 36.0),
                  child: Text(
                    widget.message,
                    style: GoogleFonts.instrumentSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                      wordSpacing: 2,
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

  IconData _toastIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }

  Color _backgroundColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Colors.green.shade600;
      case ToastType.error:
        return Colors.red.shade600;
      case ToastType.warning:
        return Colors.orange.shade700;
      case ToastType.info:
        return Colors.blue.shade600;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
