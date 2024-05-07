import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// A Firebase Crashlytics wrapper
class SynrgCrashlytics {
  /// Private constructor
  SynrgCrashlytics._privateConstructor();

  /// The single instance of SynrgCrashlytics
  static final SynrgCrashlytics _instance =
      SynrgCrashlytics._privateConstructor();

  /// Provides a global access point to the SynrgCrashlytics instance
  static SynrgCrashlytics get instance => _instance;

  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  /// Logs a custom error message
  void logError(Exception exception, StackTrace stackTrace, {String? reason}) {
    _crashlytics.recordError(exception, stackTrace, reason: reason);
  }

  /// Sets a custom key-value pair
  /// that will be attached to subsequent crash reports
  void setCustomKey({
    required String key,
    required Object value,
  }) {
    _crashlytics.setCustomKey(key, value);
  }

  /// Sets the user identifier for associating
  /// user data with subsequent crash reports
  void setUserIdentifier(String identifier) {
    _crashlytics.setUserIdentifier(identifier);
  }

  /// Logs a message that will be included in the next crash report
  void logMessage(String message) {
    _crashlytics.log(message);
  }

  /// Enables or disables automatic collection of crash reports
  void setCrashlyticsCollectionEnabled({required bool enabled}) {
    _crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }

  /// Sets a custom key-value pair dynamically, handling null values
  void setDynamicCustomKey(String key, dynamic value) {
    if (value == null) {
      // Handle null if necessary, perhaps by
      // logging a warning or using a default value.
    } else {
      _crashlytics.setCustomKey(key, value as Object);
    }
  }
}
