import 'package:equatable/equatable.dart';
import 'package:synrg/src/bloc/modal.dart';

/// This state is a facilitator to use Synrg Bloc Provide
/// It adds an alert to all states enabling seamless user feedback
class SynrgState extends Equatable {
  ///
  SynrgState({this.modal});

  /// basic implementation of copy with method,
  /// if there are more attributes it should be overwritten
  // SynrgState copyWith({SynrgModal? modal}) {
  //   return SynrgState(
  //     modal: modal ?? this.modal,
  //   );
  // }

  /// Modal attribute used by the SynrgProvider to handle user feedback alerts.
  final SynrgModal? modal;

  /// Converts the state to a map for analytics purposes.
  /// Used by the SynrgProvider to post data to analytics.
  Map<String, dynamic> toMap() {
    throw UnimplementedError('Missing to map implementation');
  }

  /// Converts the state to String for analytics purposes.
  /// Used by the SynrgProvider to post data to analytics.
  @override
  String toString() {
    throw UnimplementedError('Missing to string implementation');
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      throw UnimplementedError('Missing props implementation');
}
