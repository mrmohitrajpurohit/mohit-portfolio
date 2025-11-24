import 'package:flutter/material.dart';

class ExpandableItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const ExpandableItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  State<ExpandableItem> createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TITLE ROW
        GestureDetector(
          onTap: () => setState(() => expanded = !expanded),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BULLET ICON
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(Icons.check_circle_outline,
                    size: 20, color: Colors.black54),
              ),

              const SizedBox(width: 10),

              // TITLE + SUBTITLE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (widget.subtitle.isNotEmpty)
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                  ],
                ),
              ),

              Icon(
                expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.black87,
              ),
            ],
          ),
        ),

        // EXPANDED IMAGE
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: expanded && widget.imagePath.isNotEmpty
              ? Container(
            margin: const EdgeInsets.only(left: 36, top: 12, bottom: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.imagePath,
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          )
              : const SizedBox.shrink(),
        ),

        const Divider(height: 18),
      ],
    );
  }
}
