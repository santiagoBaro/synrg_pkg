import 'package:flutter/material.dart';
import 'package:synrg/src/visual_elements/theme.dart';
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
enum SynrgmodalType {
  /// Shows an alert dialog on the center of the view
  popup,

  /// Shows a drawer that emerges vrom the bottom of the screen
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
class SynrgModal {
  ///
  const SynrgModal({
    required this.message,
    this.actionName,
    this.action,
    this.level = AlertLevel.info,
    this.type = SynrgmodalType.toast,
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
  final SynrgmodalType type;

  ///
  void build(BuildContext context) {
    switch (type) {
      case SynrgmodalType.popup:
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(message),
              content: widget,
              actions: <Widget>[
                TextButton(
                  style: synrgTheme.secondaryButtonStyle,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                if (action != null)
                  TextButton(
                    style: synrgTheme.primaryButtonStyle,
                    onPressed: () {
                      // ignore: avoid_dynamic_calls
                      action!();
                      Navigator.of(context).pop();
                    },
                    child: Text(actionName ?? ''),
                  ),
              ],
            );
          },
        );
      case SynrgmodalType.drawer:
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
                          style: synrgTheme.secondaryButtonStyle,
                          child: const Text('Close'),
                        ),
                        if (action != null)
                          ElevatedButton(
                            onPressed: () {
                              // ignore: avoid_dynamic_calls
                              action!();
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
      case SynrgmodalType.snack:
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
                  onPressed: () {
                    // ignore: avoid_dynamic_calls
                    action!();
                  },
                )
              : null,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      case SynrgmodalType.bubble:
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
      case SynrgmodalType.overlay:
        // showModalBottomSheet(
        //   context: context,
        //   builder: (context) => widget,
        // );
        break;
      case SynrgmodalType.toast:
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