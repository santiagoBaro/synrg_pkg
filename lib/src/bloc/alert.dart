import 'package:quickalert/quickalert.dart';

/// Block Alert class
class BlocAlert {
  ///
  BlocAlert({
    required this.message,
    required this.level,
    this.title,
  });

  /// Alert message
  String message;

  /// Alert title
  String? title;

  /// Alert level
  QuickAlertType level;
}
