import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
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
    final auth = SynrgAuth();
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
      try {
        await auth.signIn(event.email, event.password);
      } catch (error) {
        emit(
          SynrNotAuthenticatedState(
            alert: BlocAlert(
              title: 'Sign In Error',
              message: error.toString(),
              level: QuickAlertType.error,
            ),
          ),
        );
      }
    });
    on<SynrLogout>((event, emit) async {
      await auth.signOut();
    });
    on<SynrRegister>((event, emit) async {
      try {
        await auth.register(event.email, event.password);
      } catch (error) {
        emit(
          SynrNotAuthenticatedState(
            alert: BlocAlert(
              message: 'Register Error: $error',
              level: QuickAlertType.error,
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
