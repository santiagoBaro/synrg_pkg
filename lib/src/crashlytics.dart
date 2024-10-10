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

  late final FirebaseCrashlytics _crashlytics;

  /// Initialization logic for `_crashlytics`
  void initialize() {
    if (!kIsWeb) {
      _crashlytics = FirebaseCrashlytics.instance;
    }
  }

  /// Logs a custom error message
  void logError(Error exception, StackTrace stackTrace, {String? reason}) {
    if (!kIsWeb) {
      try {
        _crashlytics.recordError(exception, stackTrace, reason: reason);
      } catch (e) {
        if (kDebugMode) {
          print('Error logging error: $e');
        }
      }
    }
  }

  /// Sets a custom key-value pair
  /// that will be attached to subsequent crash reports
  void setCustomKey({
    required String key,
    required Object value,
  }) {
    if (!kIsWeb) {
      try {
        _crashlytics.setCustomKey(key, value);
      } catch (e) {
        if (kDebugMode) {
          print('Error setting custom key: $e');
        }
      }
    }
  }

  /// Sets the user identifier for associating
  /// user data with subsequent crash reports
  void setUserIdentifier(String identifier) {
    if (!kIsWeb) {
      try {
        _crashlytics.setUserIdentifier(identifier);
      } catch (e) {
        if (kDebugMode) {
          print('Error setting user identifier: $e');
        }
      }
    }
  }

  /// Logs a message that will be included in the next crash report
  void logMessage(String message) {
    if (!kIsWeb) {
      try {
        _crashlytics.log(message);
      } catch (e) {
        if (kDebugMode) {
          print('Error logging message: $e');
        }
      }
    }
  }

  /// Enables or disables automatic collection of crash reports
  void setCrashlyticsCollectionEnabled({required bool enabled}) {
    if (!kIsWeb) {
      try {
        _crashlytics.setCrashlyticsCollectionEnabled(enabled);
      } catch (e) {
        if (kDebugMode) {
          print('Error setting Crashlytics collection: $e');
        }
      }
    }
  }

  /// Sets a custom key-value pair dynamically, handling null values
  void setDynamicCustomKey(String key, dynamic value) {
    if (!kIsWeb) {
      try {
        if (value == null) {
          // Handle null if necessary, perhaps by
          // logging a warning or using a default value.
        } else {
          _crashlytics.setCustomKey(key, value as Object);
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error setting custom key: $e');
        }
      }
    }
  }
}
