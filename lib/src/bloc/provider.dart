// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synrg/synrg.dart';

/// Synrg Bloc Provider, is a wrapper to the Bloc Consumer which facilitates
/// the user feedback by adding a listener for any alerts emitted from the BLoC
///
/// By using this and making all of your BLoCs states extend SynrgState,
/// you will have alerts
class SynrgBlocProvider<B extends BlocBase<Object?>> extends StatelessWidget {
  const SynrgBlocProvider({
    required this.bloc,
    required this.builder,
    super.key,
  });
  final B bloc;
  final Widget Function(BuildContext, SynrgState) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<B, Object?>(
        buildWhen: (previous, current) {
          if (previous == current) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          final synrgState = state! as SynrgState;
          SynrgAnalytics.instance.logEvent(
            synrgState.toString(),
            synrgState.toMap(),
          );
          return builder(context, state as SynrgState);
        },
        listener: (context, state) {
          state as SynrgState?;
          if (state != null && state.modal != null) {
            state.modal!.build(context);
          }
        },
      ),
    );
  }
}
