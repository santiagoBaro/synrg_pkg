import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:synrg/src/session/profile.dart';
import 'package:synrg/src/session/view/initial_state.dart';
import 'package:synrg/src/session/view/profile_complete.dart';
import 'package:synrg/src/session/view/profile_incomplete.dart';
import 'package:synrg/synrg.dart';

part 'session_event.dart';
part 'session_state.dart';

///
class SynrSessionBloc extends Bloc<SynrSessionEvent, SynrSessionState> {
  ///
  SynrSessionBloc() : super(SynrSessionInitial()) {
    on<SynrSessionEvent>((event, emit) {});
    on<SynrLogin>((event, emit) {});
    on<SynrLogout>((event, emit) {});
    on<SynrRegister>((event, emit) {});
    on<SynrUpdateProfile>((event, emit) {});
  }
}

///
class SynrgSessionProvider extends StatelessWidget {
  ///
  const SynrgSessionProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return SynrgBlocProvider<SynrSessionBloc>(
      bloc: SynrSessionBloc(),
      builder: (context, state) {
        if (state is SynrSessionInitial) {
          return const InitialState();
        }
        if (state is SynrProfileComplete) {
          return const ProfileCompleteState();
        }
        if (state is SynrProfileIncomplete) {
          return const ProfileIncompleteState();
        }
        return Container();
      },
    );
  }
}
