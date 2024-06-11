import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

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
    try {
      _crashlytics.recordError(exception, stackTrace, reason: reason);
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error logging error: $e');
      }
    }
  }

  /// Sets a custom key-value pair
  /// that will be attached to subsequent crash reports
  void setCustomKey({
    required String key,
    required Object value,
  }) {
    try {
      _crashlytics.setCustomKey(key, value);
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error setting custom key: $e');
      }
    }
  }

  /// Sets the user identifier for associating
  /// user data with subsequent crash reports
  void setUserIdentifier(String identifier) {
    try {
      _crashlytics.setUserIdentifier(identifier);
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error setting user identifier: $e');
      }
    }
  }

  /// Logs a message that will be included in the next crash report
  void logMessage(String message) {
    try {
      _crashlytics.log(message);
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error logging message: $e');
      }
    }
  }

  /// Enables or disables automatic collection of crash reports
  void setCrashlyticsCollectionEnabled({required bool enabled}) {
    try {
      _crashlytics.setCrashlyticsCollectionEnabled(enabled);
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error setting Crashlytics collection: $e');
      }
    }
  }

  /// Sets a custom key-value pair dynamically, handling null values
  void setDynamicCustomKey(String key, dynamic value) {
    try {
      if (value == null) {
        // Handle null if necessary, perhaps by
        // logging a warning or using a default value.
      } else {
        _crashlytics.setCustomKey(key, value as Object);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error setting custom key: $e');
      }
    }
  }
}
