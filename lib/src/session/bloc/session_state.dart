part of 'session_bloc.dart';

///
@immutable
sealed class SynrSessionState extends SynrgState {}

///
final class SynrSessionInitial extends SynrSessionState {}

///
final class SynrProfileComplete extends SynrSessionState {
  ///
  SynrProfileComplete(this.profile);

  ///
  final SynrgProfile profile;
}

///
final class SynrProfileIncomplete extends SynrSessionState {
  ///
  SynrProfileIncomplete(this.profile);

  ///
  final SynrgProfile profile;
}
