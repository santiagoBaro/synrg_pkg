import 'package:cloud_functions/cloud_functions.dart';
import 'package:synrg/synrg.dart';

///
class SynrgResult<T> {
  ///
  const SynrgResult({required this.result, required this.status});

  /// Result of the function call, it can be null if the status is not success.
  final T? result;

  /// Status of the function call.
  final SynrgFunctionStatus status;
}

/// Firebase functions wrapper, it calls the function with the given name and
/// parses the response to the given class.
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
  Future<SynrgResult<T>> call(Map<String, dynamic> data) async {
    final trace = await SynrgPerformance.instance.startTrace(
      'Function call ( $_name )',
    );
    try {
      final result = await _function.call<Map<String, dynamic>>(data);
      return SynrgResult(
        result: _fromMap(result.data),
        status: SynrgFunctionStatus.success,
      );
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Error,
        stackTrace,
        reason: 'Function ($_name) exception',
      );
      // TODO(dsa): Add all possible errors to the enum
      return const SynrgResult(
        result: null,
        status: SynrgFunctionStatus.failure,
      );
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
    }
  }
}

/// Possible function status
enum SynrgFunctionStatus {
  /// Success
  success,

  /// General failure
  failure,

  /// Client-side errors
  /// Generic client-side error
  clientError,

  /// Client-side errors
  /// 400 Bad Request
  badRequest,

  /// Client-side errors
  /// 401 Unauthorized
  unauthorized,

  /// Client-side errors
  /// 403 Forbidden
  forbidden,

  /// Client-side errors
  /// 404 Not Found
  notFound,

  /// Client-side errors
  /// 405 Method Not Allowed
  methodNotAllowed,

  /// Client-side errors
  /// 408 Request Timeout
  requestTimeout,

  /// Client-side errors
  /// 409 Conflict
  conflict,

  /// Client-side errors
  /// 410 Gone
  gone,

  /// Client-side errors
  /// 413 Payload Too Large
  payloadTooLarge,

  /// Client-side errors
  /// 415 Unsupported Media Type
  unsupportedMediaType,

  /// Client-side errors
  /// 429 Too Many Requests
  tooManyRequests,

  /// Server-side errors
  /// Generic server-side error
  serverError,

  /// Server-side errors
  /// 500 Internal Server Error
  internalServerError,

  /// Server-side errors
  /// 501 Not Implemented
  notImplemented,

  /// Server-side errors
  /// 502 Bad Gateway
  badGateway,

  /// Server-side errors
  /// 503 Service Unavailable
  serviceUnavailable,

  /// Server-side errors
  /// 504 Gateway Timeout
  gatewayTimeout,

  /// Server-side errors
  /// 505 HTTP Version Not Supported
  httpVersionNotSupported,
}
