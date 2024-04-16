part of 'session_bloc.dart';

///
@immutable
abstract class SynrSessionState extends SynrgState {
  ///
  SynrSessionState({super.modal});
}

/// Initial state is a loader while we check for the session state
class SynrSessionLoadingState extends SynrSessionState {
  ///
  SynrSessionLoadingState({super.modal});

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  String toString() => 'SynrSessionLoadingState';
}

///
final class SynrNotAuthenticatedState extends SynrSessionState {
  ///
  SynrNotAuthenticatedState({super.modal});

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  String toString() => 'SynrNotAuthenticatedState';
}

///
final class SynrProfileViewState extends SynrSessionState {
  ///
  SynrProfileViewState(this.profile, {super.modal});

  ///
  final SynrgProfile profile;

  @override
  Map<String, dynamic> toMap() {
    return {
      'profile': profile.toMap(),
    };
  }

  @override
  String toString() => 'SynrProfileViewState';
}

///
final class SynrProfileFormState extends SynrSessionState {
  ///
  SynrProfileFormState(this.profile, {super.modal});

  ///
  final SynrgProfile? profile;

  ///
  @override
  Map<String, dynamic> toMap() {
    return {
      'profile': profile?.toMap(),
    };
  }

  @override
  String toString() => 'SynrProfileFormState';
}
