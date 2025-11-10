import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core/utils/keys.dart';
import '../core/widgets/custom_toast.dart';

class ContactInfoViewModel with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final context = Keys.navigatorKey.currentContext;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    try {
      // 1. Save data to Firestore
      await FirebaseFirestore.instance.collection('contact_messages').add({
        'name': name,
        'email': email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // 2. Create <form> element dynamically
      final form = web.document.createElement('form') as web.HTMLFormElement;
      form.action = 'https://formsubmit.co/dcent2001@gmail.com';
      form.method = 'POST';
      form.style.display = 'none';

      // 3. Append inputs (name, email, message)
      _addHiddenInput(form, 'name', name);
      _addHiddenInput(form, 'email', email);
      _addHiddenInput(form, 'message', message);

      // 4. FormSubmit optional fields
      // Read the redirect URL from env; if provided, add the _next field
      final redirectUrl = dotenv.env['PORTFOLIO_WEB_URL'];
      if (redirectUrl != null && redirectUrl.isNotEmpty) {
        _addHiddenInput(form, '_next', redirectUrl);
      }
      _addHiddenInput(form, '_captcha', 'false');
      _addHiddenInput(form, '_template', 'table');
      _addHiddenInput(form, '_subject', 'New Contact from Portfolio Site');
      _addHiddenInput(form, '_autoresponse',
          'Thanks for contacting! I will get back to you shortly.');

      // 5. Submit the form invisibly
      web.document.body!.append(form);
      form.submit();
      form.remove();

      // 6. Show Toast
      ToastService().show(
        message: "Contact Information Submitted successfully!",
        type: ToastType.success,
        title: 'Successful',
      );

      // 7. Reset form
      formKey.currentState!.reset();
      nameController.clear();
      emailController.clear();
      messageController.clear();
    } catch (e) {
      ToastService().show(
        message: "Something went wrong. Please try again.",
        type: ToastType.error,
        title: "Failed",
      );
    }
  }

  void _addHiddenInput(web.HTMLFormElement form, String name, String value) {
    final input = web.document.createElement('input') as web.HTMLInputElement;
    input.type = 'hidden';
    input.name = name;
    input.value = value;
    form.append(input);
  }
}
