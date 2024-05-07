// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'session_bloc.dart';

///
sealed class SynrgSessionEvent {}

class SynrgAuthInit extends SynrgSessionEvent {}

///
class SynrgLogin extends SynrgSessionEvent {
  SynrgLogin({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

///
class SynrgLogout extends SynrgSessionEvent {}

///
class SynrgRegister extends SynrgSessionEvent {
  SynrgRegister({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

///
class SynrgUpdateProfile extends SynrgSessionEvent {
  SynrgUpdateProfile({
    required this.profile,
  });
  final SynrgProfile profile;
}
