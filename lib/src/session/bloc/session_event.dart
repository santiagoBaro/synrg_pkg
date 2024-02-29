// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'session_bloc.dart';

///
sealed class SynrSessionEvent {}

///
class SynrLogin extends SynrSessionEvent {
  SynrLogin({
    required this.email,
    required this.password,
  });
  String email;
  String password;
}

///
class SynrLogout extends SynrSessionEvent {}

///
class SynrRegister extends SynrSessionEvent {
  SynrRegister({
    required this.email,
    required this.password,
  });
  String email;
  String password;
}

///
class SynrUpdateProfile extends SynrSessionEvent {
  SynrUpdateProfile({
    required this.profile,
  });
  SynrgProfile profile;
}
