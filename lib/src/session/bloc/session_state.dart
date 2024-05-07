part of 'session_bloc.dart';

///
@immutable
abstract class SynrgSessionState extends SynrgState {
  ///
  SynrgSessionState({super.modal});
}

/// Initial state is a loader while we check for the session state
final class SynrgSessionLoadingState extends SynrgSessionState {
  ///
  SynrgSessionLoadingState({super.modal});

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
  SynrgNotAuthenticatedState({super.modal});

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
  SynrgProfileViewState(this.profile, {super.modal});

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
  SynrgProfileFormState(this.profile, {super.modal});

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
  SynrgLandingState(this.profile, {super.modal});

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
