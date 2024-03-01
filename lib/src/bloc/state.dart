import 'package:synrg/src/bloc/alert.dart';

/// This state is a facilitator to use Synrg Bloc Provide
/// It adds an alert to all states enabling seamless user feedback
class SynrgState {
  ///
  SynrgState({this.alert});

  ///
  SynrgState copyWith({BlocAlert? alert}) {
    return SynrgState(
      alert: alert ?? this.alert,
    );
  }

  ///
  final BlocAlert? alert;
}
