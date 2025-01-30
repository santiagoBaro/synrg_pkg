import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:synrg/synrg.dart';

part 'session_event.dart';
part 'session_state.dart';

///
class SynrgSessionBloc extends Bloc<SynrgSessionEvent, SynrgSessionState> {
  ///
  SynrgSessionBloc() : super(const SynrgSessionLoadingState()) {
    final auth = SynrgAuth.instance;
    on<SynrgAuthInit>((event, emit) async {
      auth.init();
      if (auth.user == null) {
        emit(const SynrgNotAuthenticatedState());
      } else {
        final profile = await auth.profile();
        if (profile == null || !profile.isComplete()) {
          emit(SynrgProfileFormState(profile));
        } else {
          emit(SynrgLandingState(profile));
        }
      }
    });
    on<SynrgLogin>((event, emit) async {
      SynrgProfile? profile;
      try {
        await auth.signIn(event.email, event.password);
        if (auth.user == null) {
          emit(
            const SynrgNotAuthenticatedState(
              modal: SynrgModal(
                message: 'Sign In Error',
                level: AlertLevel.error,
                type: SynrgModalType.snack,
              ),
            ),
          );
          return;
        }
        try {
          profile = await auth.profile();
          if (profile!.isComplete()) {
            emit(SynrgLandingState(profile));
          } else {
            emit(SynrgProfileFormState(profile));
          }
        } catch (error) {
          emit(const SynrgProfileFormState(null));
        }
      } catch (error) {
        emit(
          SynrgNotAuthenticatedState(
            modal: SynrgModal(
              message: 'Sign In Error: $error',
              level: AlertLevel.error,
              type: SynrgModalType.snack,
            ),
          ),
        );
      }
    });
    on<SynrgLogout>((event, emit) async {
      await auth.signOut();
      emit(
        const SynrgNotAuthenticatedState(
          modal: SynrgModal(
            message: 'Goodby',
          ),
        ),
      );
    });
    on<SynrgRegister>((event, emit) async {
      try {
        await auth.register(event.email, event.password);
        if (auth.user == null) {
          emit(
            const SynrgNotAuthenticatedState(
              modal: SynrgModal(
                message: 'Register Error',
                level: AlertLevel.error,
                type: SynrgModalType.snack,
              ),
            ),
          );
          return;
        }
        emit(const SynrgProfileFormState(null));
      } catch (error) {
        emit(
          SynrgNotAuthenticatedState(
            modal: SynrgModal(
              message: 'Register Error: $error',
              level: AlertLevel.error,
            ),
          ),
        );
      }
    });
    on<SynrgUpdateProfile>((event, emit) async {
      try {
        await event.profile.save();
        if (event.profile.isComplete()) {
          emit(SynrgLandingState(event.profile));
        } else {
          emit(SynrgProfileFormState(event.profile));
        }
      } catch (error) {
        emit(
          SynrgNotAuthenticatedState(
            modal: SynrgModal(
              message: 'Register Error: $error',
              level: AlertLevel.error,
            ),
          ),
        );
      }
    });
  }
}
