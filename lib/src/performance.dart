import 'dart:io' show Platform;
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// A Firebase Performance Monitoring wrapper
class SynrgPerformance {
  /// Private constructor
  SynrgPerformance._privateConstructor();

  /// The single instance of SynrgPerformance
  static final SynrgPerformance _instance =
      SynrgPerformance._privateConstructor();

  /// Provides a global access point to the SynrgPerformance instance
  static SynrgPerformance get instance => _instance;

  final FirebasePerformance _performance = FirebasePerformance.instance;

  /// Checks if the platform is unsupported
  bool get _isUnsupportedPlatform {
    if (kIsWeb) return true;
    try {
      return Platform.isMacOS || Platform.isWindows || Platform.isLinux;
    } catch (e) {
      return true;
    }
  }

  /// Starts a new custom trace
  Future<Trace?> startTrace(String name) async {
    if (_isUnsupportedPlatform) return null;
    final trace = _performance.newTrace(name);
    await trace.start();
    return trace;
  }

  /// Stops a custom trace
  Future<void> stopTrace(Trace? trace) async {
    if (_isUnsupportedPlatform || trace == null) return;
    await trace.stop();
  }

  /// Increments a metric for a specific trace
  void incrementMetric(Trace? trace, String metricName, int incrementBy) {
    if (_isUnsupportedPlatform || trace == null) return;
    trace.incrementMetric(metricName, incrementBy);
  }

  /// Sets a custom attribute for a trace
  void setAttribute(Trace? trace, String attributeName, String attributeValue) {
    if (_isUnsupportedPlatform || trace == null) return;
    trace.putAttribute(attributeName, attributeValue);
  }

  /// Manually tracks an HTTP request
  Future<HttpMetric?> startHttpMetric(String url, HttpMethod method) async {
    if (_isUnsupportedPlatform) return null;
    final metric = _performance.newHttpMetric(url, method);
    await metric.start();
    return metric;
  }

  /// Stops tracking an HTTP request
  Future<void> stopHttpMetric(HttpMetric? metric) async {
    if (_isUnsupportedPlatform || metric == null) return;
    await metric.stop();
  }
}
