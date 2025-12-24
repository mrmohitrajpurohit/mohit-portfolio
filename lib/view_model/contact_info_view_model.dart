import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../core/services/remote_config_service.dart';
import '../core/utils/keys.dart';
import '../core/widgets/custom_toast.dart';

class ContactInfoViewModel with ChangeNotifier {
  // ================= FORM =================
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  bool isSubmitting = false;

  // ================= SUBMIT =================
  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;
    if (isSubmitting) return;

    isSubmitting = true;
    notifyListeners();

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    final context = Keys.navigatorKey.currentContext;

    DocumentReference<Map<String, dynamic>>? docRef;

    try {
      // 1️⃣ SAVE TO FIRESTORE FIRST (always)
      docRef = await FirebaseFirestore.instance
          .collection('contact_messages')
          .add({
        'name': name,
        'email': email,
        'message': message,
        'createdAt': FieldValue.serverTimestamp(),
        'emailSent': false,
        'emailError': null,
      });

      // 2️⃣ SEND EMAIL (EmailJS)
      final emailResult = await _sendEmail(
        name: name,
        email: email,
        message: message,
      );

      // 3️⃣ UPDATE EMAIL STATUS
      await docRef.update({
        'emailSent': emailResult.success,
        'emailError': emailResult.error,
      });

      // 4️⃣ SUCCESS TOAST
      ToastService().show(
        title: 'Message Sent',
        message:
        emailResult.success
            ? 'Your message has been sent successfully.'
            : 'Message saved, but email delivery failed.',
        type: emailResult.success ? ToastType.success : ToastType.warning,
      );

      // 5️⃣ RESET FORM
      formKey.currentState!.reset();
      nameController.clear();
      emailController.clear();
      messageController.clear();
    } catch (e) {
      ToastService().show(
        title: 'Failed',
        message: 'Something went wrong. Please try again.',
        type: ToastType.error,
      );
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  // ================= EMAILJS =================
  Future<_EmailResult> _sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final config = RemoteConfigService.instance.buildConfig;

      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

      final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': config.emailJsServiceId,
          'template_id': config.emailJsTemplateId,
          'user_id': config.emailJsPublicKey,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message,
            'to_email': 'mrmohitrajpurohit@gmail.com',
          }
        }),
      );

      if (response.statusCode == 200) {
        return _EmailResult.success();
      } else {
        return _EmailResult.failure(
          'EmailJS error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return _EmailResult.failure(e.toString());
    }
  }
}

// ================= INTERNAL RESULT =================
class _EmailResult {
  final bool success;
  final String? error;

  _EmailResult({required this.success, this.error});

  factory _EmailResult.success() {
    return _EmailResult(success: true);
  }

  factory _EmailResult.failure(String error) {
    return _EmailResult(success: false, error: error);
  }
}
