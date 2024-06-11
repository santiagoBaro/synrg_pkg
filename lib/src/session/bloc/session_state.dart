part of 'session_bloc.dart';

///
@immutable
abstract class SynrgSessionState extends SynrgState {
  ///
  const SynrgSessionState({super.modal});
}

/// Initial state is a loader while we check for the session state
final class SynrgSessionLoadingState extends SynrgSessionState {
  ///
  const SynrgSessionLoadingState({super.modal});

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  String toString() => 'SynrgSessionLoadingState';
}

///
final class SynrgNotAuthenticatedState extends SynrgSessionState {
  ///
  const SynrgNotAuthenticatedState({super.modal});

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  String toString() => 'SynrgNotAuthenticatedState';
}

///
final class SynrgProfileViewState extends SynrgSessionState {
  ///
  const SynrgProfileViewState(this.profile, {super.modal});

  ///
  final SynrgProfile profile;

  @override
  Map<String, dynamic> toMap() {
    return {
      'profile': profile.toMap(),
    };
  }

  @override
  String toString() => 'SynrgProfileViewState';
}

///
final class SynrgProfileFormState extends SynrgSessionState {
  ///
  const SynrgProfileFormState(this.profile, {super.modal});

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
  String toString() => 'SynrgProfileFormState';
}

///
final class SynrgLandingState extends SynrgSessionState {
  ///
  const SynrgLandingState(this.profile, {super.modal});

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
  String toString() => 'SynrgAuthenticatedState';
}
