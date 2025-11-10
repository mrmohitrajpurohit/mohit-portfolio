import 'package:flutter/material.dart';

class HoverScrollCardVerticalController {
  void Function()? scrollToTop;
  void Function()? scrollToBottom;

  void triggerScrollToTop() => scrollToTop?.call();
  void triggerScrollToBottom() => scrollToBottom?.call();
}

class HoverScrollCardVertical extends StatefulWidget {
  final Color backgroundColor;
  final double height;
  final double width;
  final List<Widget> children;
  final HoverScrollCardVerticalController? controller;

  const HoverScrollCardVertical({
    super.key,
    this.backgroundColor = Colors.deepPurpleAccent,
    this.height = 60,
    this.width = 400,
    required this.children,
    this.controller,
  });

  @override
  State<HoverScrollCardVertical> createState() =>
      _HoverScrollCardVerticalState();
}

class _HoverScrollCardVerticalState extends State<HoverScrollCardVertical> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.scrollToTop = _scrollToTop;
      widget.controller!.scrollToBottom = _scrollToBottom;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _scrollToBottom(),
      onExit: (_) => _scrollToTop(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior()
                .copyWith(overscroll: false, scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
