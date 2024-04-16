// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

///
class SynrgColors {
  ///
  SynrgColors({
    required this.brand,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.background,
    required this.cardBackground,
    required this.shadow,
    required this.highlights,
    required this.titleTextColor,
    required this.subtitleTextColor,
    required this.bodyTextColor,
    required this.highlightTextColor,
    required this.success,
    required this.error,
    required this.warning,
    required this.confirm,
    required this.info,
    required this.loading,
    required this.borderColor,
    required this.disabledColor,
    required this.textOnPrimary,
    required this.textOnSecondary,
    required this.textOnTertiary,
    required this.linkColor,
    required this.overlayColor,
    required this.dividerColor,
    required this.inputFieldColor,
    required this.placeholderTextColor,
    required this.hoverColor,
    required this.pressedColor,
    required this.focusColor,
  });

  ///
  SynrgColors.blue()
      : brand = Colors.blue,
        primary = Colors.blue,
        secondary = Colors.lightBlue,
        tertiary = Colors.cyan,
        background = Colors.white,
        cardBackground = Colors.blue[50]!,
        shadow = Colors.blueGrey[300]!,
        highlights = Colors.blue[200]!,
        titleTextColor = Colors.blue[900]!,
        subtitleTextColor = Colors.blue[800]!,
        bodyTextColor = Colors.black,
        highlightTextColor = Colors.blue[600]!,
        success = Colors.green,
        error = Colors.red,
        warning = Colors.orange,
        confirm = Colors.green[600]!,
        info = Colors.lightBlue[400]!,
        loading = Colors.blue[300]!,
        borderColor = Colors.blueGrey[100]!,
        disabledColor = Colors.grey,
        textOnPrimary = Colors.white,
        textOnSecondary = Colors.white70,
        textOnTertiary = Colors.black,
        linkColor = Colors.blue[800]!,
        overlayColor = Colors.blueGrey[50]!.withOpacity(0.5),
        dividerColor = Colors.blueGrey[200]!,
        inputFieldColor = Colors.blue[50]!,
        placeholderTextColor = Colors.blueGrey[300]!,
        hoverColor = Colors.blue[300]!,
        pressedColor = Colors.blue[700]!,
        focusColor = Colors.blue[600]!;

  ///
  SynrgColors.red()
      : brand = Colors.red.shade900,
        primary = Colors.red,
        secondary = Colors.red,
        tertiary = Colors.pink,
        background = Colors.red.shade50,
        cardBackground = Colors.white,
        shadow = Colors.red.shade100,
        highlights = Colors.redAccent.shade100,
        titleTextColor = Colors.red.shade900,
        subtitleTextColor = Colors.red.shade700,
        bodyTextColor = Colors.black,
        highlightTextColor = Colors.red.shade600,
        success = Colors.green,
        error = Colors.red.shade800,
        warning = Colors.orange,
        confirm = Colors.red.shade300,
        info = Colors.teal,
        loading = Colors.redAccent,
        borderColor = Colors.red.shade200,
        disabledColor = Colors.grey,
        textOnPrimary = Colors.white,
        textOnSecondary = Colors.black,
        textOnTertiary = Colors.black,
        linkColor = Colors.red.shade800,
        overlayColor = Colors.red.shade100.withOpacity(0.5),
        dividerColor = Colors.red.shade200,
        inputFieldColor = Colors.red.shade50,
        placeholderTextColor = Colors.red.shade300,
        hoverColor = Colors.red.shade200,
        pressedColor = Colors.red.shade700,
        focusColor = Colors.red.shade400;

  ///
  SynrgColors.yellow()
      : brand = Colors.yellow.shade800,
        primary = Colors.yellow,
        secondary = Colors.yellow,
        tertiary = Colors.amber,
        background = Colors.yellow.shade50,
        cardBackground = Colors.white,
        shadow = Colors.yellow.shade100,
        highlights = Colors.yellowAccent.shade100,
        titleTextColor = Colors.yellow.shade900,
        subtitleTextColor = Colors.yellow.shade700,
        bodyTextColor = Colors.black,
        highlightTextColor = Colors.yellow.shade600,
        success = Colors.green,
        error = Colors.red,
        warning = Colors.orange.shade700,
        confirm = Colors.yellow.shade400,
        info = Colors.lightBlue,
        loading = Colors.yellowAccent.shade400,
        borderColor = Colors.yellow.shade200,
        disabledColor = Colors.grey,
        textOnPrimary = Colors.white,
        textOnSecondary = Colors.black,
        textOnTertiary = Colors.black,
        linkColor = Colors.yellow.shade800,
        overlayColor = Colors.yellow.shade100.withOpacity(0.5),
        dividerColor = Colors.yellow.shade200,
        inputFieldColor = Colors.yellow.shade50,
        placeholderTextColor = Colors.yellow.shade300,
        hoverColor = Colors.yellow.shade200,
        pressedColor = Colors.yellow.shade700,
        focusColor = Colors.yellow.shade400;

  ///
  SynrgColors.green()
      : brand = Colors.green.shade800,
        primary = Colors.green,
        secondary = Colors.green,
        tertiary = Colors.lightGreen,
        background = Colors.green.shade50,
        cardBackground = Colors.white,
        shadow = Colors.green.shade100,
        highlights = Colors.greenAccent.shade100,
        titleTextColor = Colors.green.shade900,
        subtitleTextColor = Colors.green.shade700,
        bodyTextColor = Colors.black,
        highlightTextColor = Colors.green.shade600,
        success = Colors.green,
        error = Colors.red,
        warning = Colors.orange.shade700,
        confirm = Colors.yellow.shade400,
        info = Colors.lightBlue,
        loading = Colors.greenAccent.shade400,
        borderColor = Colors.green.shade200,
        disabledColor = Colors.grey,
        textOnPrimary = Colors.white,
        textOnSecondary = Colors.black,
        textOnTertiary = Colors.black,
        linkColor = Colors.green.shade800,
        overlayColor = Colors.green.shade100.withOpacity(0.5),
        dividerColor = Colors.green.shade200,
        inputFieldColor = Colors.green.shade50,
        placeholderTextColor = Colors.green.shade300,
        hoverColor = Colors.green.shade200,
        pressedColor = Colors.green.shade700,
        focusColor = Colors.green.shade400;

  /// Pallet
  final Color brand;
  final MaterialColor primary;
  final MaterialColor secondary;
  final MaterialColor tertiary;

  /// UI
  final Color background;
  final Color cardBackground;
  final Color shadow;
  final Color highlights;

  /// Text Colors
  final Color titleTextColor;
  final Color subtitleTextColor;
  final Color bodyTextColor;
  final Color highlightTextColor;
  final Color textOnPrimary;
  final Color textOnSecondary;
  final Color textOnTertiary;
  final Color placeholderTextColor;

  /// Alerts Colors
  final Color success;
  final Color error;
  final Color warning;
  final Color confirm;
  final Color info;
  final Color loading;

  /// Additional UI Colors
  final Color borderColor;
  final Color disabledColor;
  final Color linkColor;
  final Color overlayColor;
  final Color dividerColor;
  final Color inputFieldColor;
  final Color hoverColor;
  final Color pressedColor;
  final Color focusColor;

  // copyWith method
  SynrgColors copyWith({
    Color? brand,
    MaterialColor? primary,
    MaterialColor? secondary,
    MaterialColor? tertiary,
    Color? background,
    Color? cardBackground,
    Color? shadow,
    Color? highlights,
    Color? titleTextColor,
    Color? subtitleTextColor,
    Color? bodyTextColor,
    Color? highlightTextColor,
    Color? success,
    Color? error,
    Color? warning,
    Color? confirm,
    Color? info,
    Color? loading,
    Color? borderColor,
    Color? disabledColor,
    Color? textOnPrimary,
    Color? textOnSecondary,
    Color? textOnTertiary,
    Color? linkColor,
    Color? overlayColor,
    Color? dividerColor,
    Color? inputFieldColor,
    Color? placeholderTextColor,
    Color? hoverColor,
    Color? pressedColor,
    Color? focusColor,
  }) {
    return SynrgColors(
      brand: brand ?? this.brand,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      background: background ?? this.background,
      cardBackground: cardBackground ?? this.cardBackground,
      shadow: shadow ?? this.shadow,
      highlights: highlights ?? this.highlights,
      titleTextColor: titleTextColor ?? this.titleTextColor,
      subtitleTextColor: subtitleTextColor ?? this.subtitleTextColor,
      bodyTextColor: bodyTextColor ?? this.bodyTextColor,
      highlightTextColor: highlightTextColor ?? this.highlightTextColor,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      confirm: confirm ?? this.confirm,
      info: info ?? this.info,
      loading: loading ?? this.loading,
      borderColor: borderColor ?? this.borderColor,
      disabledColor: disabledColor ?? this.disabledColor,
      textOnPrimary: textOnPrimary ?? this.textOnPrimary,
      textOnSecondary: textOnSecondary ?? this.textOnSecondary,
      textOnTertiary: textOnTertiary ?? this.textOnTertiary,
      linkColor: linkColor ?? this.linkColor,
      overlayColor: overlayColor ?? this.overlayColor,
      dividerColor: dividerColor ?? this.dividerColor,
      inputFieldColor: inputFieldColor ?? this.inputFieldColor,
      placeholderTextColor: placeholderTextColor ?? this.placeholderTextColor,
      hoverColor: hoverColor ?? this.hoverColor,
      pressedColor: pressedColor ?? this.pressedColor,
      focusColor: focusColor ?? this.focusColor,
    );
  }
}
