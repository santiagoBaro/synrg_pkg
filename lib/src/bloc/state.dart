import 'package:synrg/src/bloc/alert.dart';

/// Base state
abstract class SynrgState {
  ///
  SynrgState({this.alert});

  ///
  final BlocAlert? alert;
}
