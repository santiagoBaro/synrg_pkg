import 'package:cloud_functions/cloud_functions.dart';
import 'package:synrg/synrg.dart';

///
class SynrgFunction<T extends SynrgClass> {
  ///
  SynrgFunction(String name, T Function(Map<String, dynamic>) fromMap) {
    _function = FirebaseFunctions.instance.httpsCallable(name);
    _name = name;
    _fromMap = fromMap;
  }

  late HttpsCallable _function;
  late String _name;
  late T Function(Map<String, dynamic>) _fromMap;

  /// Call function method with performance monitoring
  Future<T?> call(Map<String, dynamic> data) async {
    final trace =
        await SynrgPerformance.instance.startTrace('function call ( $_name )');
    try {
      final result = await _function.call<Map<String, dynamic>>(data);
      SynrgPerformance.instance.incrementMetric(trace, 'success', 1);
      return _fromMap(result.data);
    } catch (e, stackTrace) {
      SynrgPerformance.instance.incrementMetric(trace, 'failure', 1);
      SynrgCrashlytics.instance.logError(
        e as Exception,
        stackTrace,
        reason: 'Function ($_name) exception',
      );
      return null;
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
    }
  }
}
