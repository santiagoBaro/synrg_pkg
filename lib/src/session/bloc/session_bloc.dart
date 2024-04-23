import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:synrg/src/session/view/loading.dart';
import 'package:synrg/src/session/view/not_authenticated.dart';
import 'package:synrg/src/session/view/profile_form.dart';
import 'package:synrg/src/session/view/profile_view.dart';
import 'package:synrg/synrg.dart';

part 'session_event.dart';
part 'session_state.dart';

///
class SynrSessionBloc extends Bloc<SynrSessionEvent, SynrSessionState> {
  ///
  SynrSessionBloc() : super(SynrSessionLoadingState()) {
    final auth = SynrgAuth.instance;
    on<SynrgAuthInit>((event, emit) async {
      if (auth.user == null) {
        emit(SynrNotAuthenticatedState());
      } else {
        final profile = await auth.profile();
        if (profile == null || !profile.isComplete()) {
          emit(SynrProfileFormState(profile));
        } else {
          emit(SynrProfileViewState(profile));
        }
      }
    });
    on<SynrLogin>((event, emit) async {
      SynrgProfile? profile;
      try {
        await auth.signIn(event.email, event.password);
        if (auth.user == null) {
          emit(
            SynrNotAuthenticatedState(
              modal: const SynrgModal(
                message: 'Sign In Error',
                level: AlertLevel.error,
                type: SynrgmodalType.snack,
              ),
            ),
          );
          return;
        }
        try {
          profile = await auth.profile();
          if (profile!.isComplete()) {
            emit(SynrProfileViewState(profile));
          } else {
            emit(SynrProfileFormState(profile));
          }
        } catch (error) {
          emit(SynrProfileFormState(null));
        }
      } catch (error) {
        emit(
          SynrNotAuthenticatedState(
            modal: SynrgModal(
              message: 'Sign In Error: $error',
              level: AlertLevel.error,
              type: SynrgmodalType.snack,
            ),
          ),
        );
      }
    });
    on<SynrLogout>((event, emit) async {
      await auth.signOut();
      emit(
        SynrNotAuthenticatedState(
          modal: const SynrgModal(
            message: 'Goodby',
          ),
        ),
      );
    });
    on<SynrRegister>((event, emit) async {
      try {
        await auth.register(event.email, event.password);
        if (auth.user == null) {
          emit(
            SynrNotAuthenticatedState(
              modal: const SynrgModal(
                message: 'Register Error',
                level: AlertLevel.error,
                type: SynrgmodalType.snack,
              ),
            ),
          );
          return;
        }
        emit(SynrProfileFormState(null));
      } catch (error) {
        emit(
          SynrNotAuthenticatedState(
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
          emit(SynrProfileViewState(event.profile));
        } else {
          emit(SynrProfileFormState(event.profile));
        }
      } catch (error) {
        emit(
          SynrNotAuthenticatedState(
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

/// This serves only as an example, as SynrgProfile is an abstract.
class SynrgSessionProvider extends StatelessWidget {
  ///
  const SynrgSessionProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return SynrgBlocProvider<SynrSessionBloc>(
      bloc: SynrSessionBloc(),
      builder: (context, state) {
        if (state is SynrSessionLoadingState) {
          return const Loading();
        }
        if (state is SynrNotAuthenticatedState) {
          return NotAuthenticated();
        }
        if (state is SynrProfileFormState) {
          return SynrgProfileForm();
        }
        if (state is SynrProfileViewState) {
          return const SynrgProfileView();
        }
        return Container();
      },
    );
  }
}
