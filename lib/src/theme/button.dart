// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:synrg/synrg.dart';

class SynrgButton extends StatelessWidget {
  const SynrgButton({
    super.key,
    this.onPressed,
    this.text,
    this.status,
  });

  const SynrgButton.primary({
    super.key,
    this.onPressed,
    this.text,
    this.status,
  });

  final void Function()? onPressed;
  final String? text;
  final RequestStatus? status;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text ?? ''),
    );
  }
}

class SynrgButtonTheme {
  SynrgButtonTheme({
    this.primary = const ButtonStyle(),
    this.secondary = const ButtonStyle(),
    this.success = const ButtonStyle(),
    this.error = const ButtonStyle(),
    this.warning = const ButtonStyle(),
    this.confirm = const ButtonStyle(),
    this.info = const ButtonStyle(),
    this.disabled = const ButtonStyle(),
  });

  ButtonStyle primary;
  ButtonStyle secondary;
  ButtonStyle success;
  ButtonStyle error;
  ButtonStyle warning;
  ButtonStyle confirm;
  ButtonStyle info;
  ButtonStyle disabled;

  SynrgButtonTheme copyWith({
    ButtonStyle? primary,
    ButtonStyle? secondary,
    ButtonStyle? success,
    ButtonStyle? error,
    ButtonStyle? warning,
    ButtonStyle? confirm,
    ButtonStyle? info,
    ButtonStyle? disabled,
  }) {
    return SynrgButtonTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      confirm: confirm ?? this.confirm,
      info: info ?? this.info,
      disabled: disabled ?? this.disabled,
    );
  }
}
