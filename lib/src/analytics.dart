import 'package:firebase_analytics/firebase_analytics.dart';

/// A Firebase Analytics wrapper
class SynrgAnalytics {
  /// Private constructor
  SynrgAnalytics._privateConstructor();

  /// The single instance of SynrgAnalytics
  static final SynrgAnalytics _instance = SynrgAnalytics._privateConstructor();

  /// Provides a global access point to the SynrgAnalytics instance
  static SynrgAnalytics get instance => _instance;

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Logs a custom event with optional parameters
  Future<void> logEvent(
    String eventName, [
    Map<String, dynamic>? parameters,
  ]) async {
    if (parameters != null) {
      parameters.removeWhere((key, value) => value == null);

      parameters = parameters.map((key, value) {
        if (value is String || value is num || value == null) {
          return MapEntry(key, value);
        } else if (value is DateTime) {
          return MapEntry(key, value.toIso8601String());
        } else if (value is List) {
          return MapEntry(key, value.join(','));
        } else if (value is Map) {
          return MapEntry(key, value.toString());
        } else {
          return MapEntry(key, value.toString());
        }
      });
    }

    await _analytics.logEvent(
      name: eventName,
      parameters: _castToObjectMap(parameters),
    );
  }

  /// Sets user properties, which can be used to segment
  /// users in your analytics reports
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  /// Sets the user ID, which can be used to identify a user
  /// across various platforms and sessions
  Future<void> setUserId(String id) async {
    await _analytics.setUserId(id: id);
  }

  /// Logs the user's screen view, adapted to the new API
  Future<void> logScreenView(
    String screenName, {
    String screenClass = 'Flutter',
    Map<String, Object?>? parameters,
  }) async {
    parameters?.removeWhere((key, value) => value == null);
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
      parameters: _castToObjectMap(parameters),
    );
  }
}

Map<String, Object>? _castToObjectMap(Map<String, dynamic>? input) {
  if (input == null) return null;

  final result = <String, Object>{};

  input.forEach((key, value) {
    if (value == null) return;

    if (value is String || value is num || value is bool) {
      result[key] = value as Object;
    } else if (value is DateTime) {
      result[key] = value.toIso8601String();
    } else if (value is List) {
      result[key] = value.join(',');
    } else {
      result[key] = value.toString();
    }
  });

  return result;
}
