import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../config/build_config.dart';

class RemoteConfigService {
  RemoteConfigService._();

  static final RemoteConfigService instance = RemoteConfigService._();

  late FirebaseRemoteConfig _remoteConfig;
  late BuildConfig buildConfig;

  Future<void> init() async {
    _remoteConfig = FirebaseRemoteConfig.instance;

    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await _remoteConfig.fetchAndActivate();

    final jsonString = _remoteConfig.getString('build_config');

    if (jsonString.isEmpty) {
      throw Exception('Remote Config: build_config is empty');
    }

    final Map<String, dynamic> json = jsonDecode(jsonString);
    buildConfig = BuildConfig.fromJson(json);
  }
}
