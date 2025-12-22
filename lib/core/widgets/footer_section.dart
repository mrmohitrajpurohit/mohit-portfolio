import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FooterSection extends StatelessWidget {
  final bool isSticky;

  const FooterSection({super.key, this.isSticky = false});

  void _open(String url) async {
    await launchUrlString(url, webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isSticky ? 80 : null,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
        boxShadow: isSticky
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ================= MAIN ROW =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // LEFT: NAME
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Mohit",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Software Developer",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              // CENTER: SOCIAL ICONS
              Row(
                children: [
                  _socialIcon(
                    iconPath: 'assets/icons/github_icon.png',
                    onTap: () => _open('https://github.com/mohit-01-code'),
                  ),
                  _socialIcon(
                    iconPath: 'assets/icons/linkdin_icon.png',
                    onTap: () =>
                        _open('https://www.linkedin.com/in/mohit-rajpurohit-8b9ba41a3/'),
                  ),
                  _socialIcon(
                    iconPath: 'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png',
                    onTap: () =>
                        _open('https://www.instagram.com/_mohit_rajguru/'),
                  ),
                ],
              ),

              // RIGHT: RESUME
              TextButton.icon(
                onPressed: () =>
                    _open('assets/files/Mohit_Resume.pdf'),
                icon: const Icon(Icons.download, size: 16),
                label: const Text("Resume"),
              ),
            ],
          ),

          // ================= COPYRIGHT (ONLY SCROLL MODE) =================
          if (!isSticky) ...[
            const SizedBox(height: 10),
            Text(
              "© ${DateTime.now().year} Mohit • Built with Flutter Web",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ================= SOCIAL ICON =================
  Widget _socialIcon({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: iconPath.contains('http')? Image.network(iconPath,
            height: 18,
            width: 18,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.link, size: 18),) :Image.asset(
            iconPath,
            height: 18,
            width: 18,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.link, size: 18),
          ),
        ),
      ),
    );
  }
}
