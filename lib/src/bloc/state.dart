import 'package:synrg/src/bloc/alert.dart';

/// This state is a facilitator to use Synrg Bloc Provide
/// It adds an alert to all states enabling seamless user feedback
class SynrgState {
  ///
  SynrgState({this.alert});

  /// basic implementation of copy with method,
  /// if there are more attributes it should be overwritten
  SynrgState copyWith({BlocAlert? alert}) {
    return SynrgState(
      alert: alert ?? this.alert,
    );
  }

  /// Alert attribute used by the SynrgProvider to handle user feedback alerts.
  final BlocAlert? alert;

  /// Converts the state to a map for analytics purposes.
  /// Used by the SynrgProvider to post data to analytics.
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }

  /// Converts the state to String for analytics purposes.
  /// Used by the SynrgProvider to post data to analytics.
  @override
  String toString() {
    throw UnimplementedError();
  }
}
