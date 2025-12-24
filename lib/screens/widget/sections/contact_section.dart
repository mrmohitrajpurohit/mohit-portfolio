import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: const Center(
        child: Text(
          "CONTACT SECTION (Phase 7)",
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
