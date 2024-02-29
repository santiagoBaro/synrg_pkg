// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:synrg/src/bloc/state.dart';

///
class SynrgBlocProvider<B extends BlocBase<Object?>> extends StatelessWidget {
  const SynrgBlocProvider({
    required this.bloc,
    required this.builder,
    super.key,
  });
  final B bloc;
  final Widget Function(BuildContext, B) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<B, Object?>(
        buildWhen: (previous, current) {
          if (previous.toString() == current.toString()) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          return builder(context, state! as B);
        },
        listener: (context, state) {
          state as SynrgState?;

          if (state != null &&
              state.alert != null &&
              (kDebugMode ||
                  state.alert!.level.name != QuickAlertType.warning.name)) {
            QuickAlert.show(
              context: context,
              type: state.alert!.level,
              title: state.alert!.title,
              text: state.alert!.message,
            );
          }
        },
      ),
    );
  }
}

enum QuickAlertType {
  /// success alert type
  success,

  /// error alert type
  error,

  /// warning alert type
  warning,

  /// confirm alert type
  confirm,

  /// info alert type
  info,

  /// loading alert type
  loading,

  /// custom alert type
  custom,
}
