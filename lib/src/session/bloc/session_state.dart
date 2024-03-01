part of 'session_bloc.dart';

///
@immutable
abstract class SynrSessionState extends SynrgState {
  ///
  SynrSessionState({super.alert});
}

/// Initial state is a loader while we check for the session state
class SynrSessionLoadingState extends SynrSessionState {
  ///
  SynrSessionLoadingState({super.alert});
}

///
final class SynrNotAuthenticatedState extends SynrSessionState {
  ///
  SynrNotAuthenticatedState({super.alert});
}

///
final class SynrProfileViewState extends SynrSessionState {
  ///
  SynrProfileViewState(this.profile, {super.alert});

  ///
  final SynrgProfile profile;
}

///
final class SynrProfileFormState extends SynrSessionState {
  ///
  SynrProfileFormState(this.profile, {super.alert});

  ///
  final SynrgProfile? profile;
}
