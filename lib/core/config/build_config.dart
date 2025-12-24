import 'dart:math';

class BuildConfig {
  // Firebase
  final String apiKey;
  final String authDomain;
  final String projectId;
  final String storageBucket;
  final String messagingSenderId;
  final String appId;
  final String measurementId;

  // EmailJS
  final String emailJsServiceId;
  final String emailJsTemplateId;
  final String emailJsPublicKey;

  BuildConfig({
    required this.apiKey,
    required this.authDomain,
    required this.projectId,
    required this.storageBucket,
    required this.messagingSenderId,
    required this.appId,
    required this.measurementId,
    required this.emailJsServiceId,
    required this.emailJsTemplateId,
    required this.emailJsPublicKey,
  });

  factory BuildConfig.fromJson(Map<String, dynamic> json) {
    return BuildConfig(
      apiKey: json['apiKey'],
      authDomain: json['authDomain'],
      projectId: json['projectId'],
      storageBucket: json['storageBucket'],
      messagingSenderId: json['messagingSenderId'],
      appId: json['appId'],
      measurementId: json['measurementId'] ?? "",
      emailJsServiceId: json['emailJsServiceId'],
      emailJsTemplateId: json['template_id'],
      emailJsPublicKey: json['emailJsPublicKey'],
    );
  }
}
