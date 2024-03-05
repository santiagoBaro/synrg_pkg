import 'package:firebase_performance/firebase_performance.dart';

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

  /// Starts a new custom trace
  Future<Trace> startTrace(String name) async {
    final trace = _performance.newTrace(name);
    await trace.start();
    return trace;
  }

  /// Stops a custom trace
  Future<void> stopTrace(Trace trace) async {
    await trace.stop();
  }

  /// Increments a metric for a specific trace
  void incrementMetric(Trace trace, String metricName, int incrementBy) {
    trace.incrementMetric(metricName, incrementBy);
  }

  /// Sets a custom attribute for a trace
  void setAttribute(Trace trace, String attributeName, String attributeValue) {
    trace.putAttribute(attributeName, attributeValue);
  }

  /// Manually tracks an HTTP request
  Future<HttpMetric> startHttpMetric(String url, HttpMethod method) async {
    final metric = _performance.newHttpMetric(url, method);
    await metric.start();
    return metric;
  }

  /// Stops tracking an HTTP request
  Future<void> stopHttpMetric(HttpMetric metric) async {
    await metric.stop();
  }
}
