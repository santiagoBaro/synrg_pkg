import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:synrg/synrg.dart';

/// A Firebase Remote Config wrapper
class SynrgRemoteConfig {
  /// Private constructor
  SynrgRemoteConfig._privateConstructor();

  /// The single instance of SynrgRemoteConfig
  static final SynrgRemoteConfig _instance =
      SynrgRemoteConfig._privateConstructor();

  /// Provides a global access point to the SynrgRemoteConfig instance
  static SynrgRemoteConfig get instance => _instance;

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  /// Initializes Remote Config with default values and fetches parameters
  Future<void> initialize({Map<String, dynamic>? defaultValues}) async {
    await _remoteConfig.setDefaults(defaultValues ?? {});
    await fetchAndActivate();
  }

  /// Fetches the latest parameters and activates them
  Future<void> fetchAndActivate() async {
    try {
      // Fetch remote config values and activate them
      await _remoteConfig.fetchAndActivate();
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Error,
        stackTrace,
        reason: 'Remote Config Fetch and Activate Exception',
      );
    }
  }

  /// Gets a boolean value from Remote Config
  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  /// Gets an integer value from Remote Config
  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  /// Gets a double value from Remote Config
  double getDouble(String key) {
    return _remoteConfig.getDouble(key);
  }

  /// Gets a string value from Remote Config
  String getString(String key) {
    return _remoteConfig.getString(key);
  }
}
