import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:synrg/src/theme/theme.dart';
import 'package:toastification/toastification.dart';

/// Alert Type
enum AlertLevel {
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

///
enum SynrgModalType {
  /// Shows an alert dialog on the center of the view
  popup,

  /// Shows a drawer that emerges from the bottom of the screen
  drawer,

  /// Shows a snackbar on the bottom of the screen
  snack,

  /// Shows a floating notification
  bubble,

  /// Shows a full screen overlay
  overlay,

  /// Shows a notification
  toast,
}

///
class SynrgModal extends Equatable {
  ///
  const SynrgModal({
    required this.message,
    this.actionName,
    this.action,
    this.level = AlertLevel.info,
    this.type = SynrgModalType.toast,
    this.widget,
  });

  ///
  final String message;

  ///
  final String? actionName;

  ///
  final Function? action;

  ///
  final Widget? widget;

  ///
  final AlertLevel level;

  ///
  final SynrgModalType type;

  ///
  void build(BuildContext context) {
    switch (type) {
      case SynrgModalType.popup:
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(message),
              content: widget,
              actions: <Widget>[
                TextButton(
                  style: synrgTheme.button.secondary,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                if (action != null)
                  TextButton(
                    style: synrgTheme.button.primary,
                    onPressed: () async {
                      // ignore: avoid_dynamic_calls
                      await action!();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(actionName ?? ''),
                  ),
              ],
            );
          },
        );
      case SynrgModalType.drawer:
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              constraints: const BoxConstraints(minHeight: 200),
              color: synrgTheme.colors.background,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(message),
                    if (widget != null) widget!,
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: synrgTheme.button.secondary,
                          child: const Text('Close'),
                        ),
                        if (action != null)
                          ElevatedButton(
                            onPressed: () async {
                              // ignore: avoid_dynamic_calls
                              await action!();
                            },
                            child: Text(actionName ?? ''),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      case SynrgModalType.snack:
        final snackBar = SnackBar(
          content: Column(
            children: [
              Text(message),
              if (widget != null) widget!,
            ],
          ),
          action: (action != null)
              ? SnackBarAction(
                  label: actionName ?? '',
                  onPressed: () async {
                    // ignore: avoid_dynamic_calls
                    await action!();
                  },
                )
              : null,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      case SynrgModalType.bubble:
        toastification.show(
          context: context,
          title: Column(
            children: [
              Text(message),
              if (widget != null) widget!,
            ],
          ),
          autoCloseDuration: const Duration(seconds: 3),
          style: synrgTheme.toastStyle,
          alignment: Alignment.topRight,
          type: _toToastLevel(level),
        );
      case SynrgModalType.overlay:
        // showModalBottomSheet(
        //   context: context,
        //   builder: (context) => widget,
        // );
        break;
      case SynrgModalType.toast:
        toastification.show(
          context: context,
          title: Column(
            children: [
              Text(message),
              if (widget != null) widget!,
            ],
          ),
          autoCloseDuration: const Duration(seconds: 3),
          style: synrgTheme.toastStyle,
          type: _toToastLevel(level),
        );
    }
  }

  @override
  List<Object?> get props => [message, actionName, action, widget, level, type];
}

ToastificationType _toToastLevel(AlertLevel level) {
  switch (level) {
    case AlertLevel.error:
      return ToastificationType.error;
    case AlertLevel.warning:
      return ToastificationType.warning;
    case AlertLevel.success:
      return ToastificationType.success;
    case AlertLevel.info:
      return ToastificationType.info;
    case AlertLevel.confirm:
      return ToastificationType.success;
    case AlertLevel.loading:
      return ToastificationType.info;
    case AlertLevel.custom:
      return ToastificationType.info;
  }
}
