// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:synrg/src/visual_elements/colors.dart';
import 'package:toastification/toastification.dart';

SynrgTheme synrgTheme = SynrgTheme();

class SynrgTheme {
  SynrgTheme({
    SynrgColors? colors,
    TextTheme? titleTheme,
    TextTheme? subtitleTheme,
    TextTheme? bodyTheme,
    TextTheme? placeholderTheme,
    TextTheme? highlightTheme,
    TextTheme? linkTheme,
    TextTheme? buttonTextTheme,
    ButtonStyle? primaryButtonStyle,
    ButtonStyle? secondaryButtonStyle,
    ButtonStyle? successButtonStyle,
    ButtonStyle? errorButtonStyle,
    ButtonStyle? warningButtonStyle,
    ButtonStyle? confirmButtonStyle,
    ButtonStyle? infoButtonStyle,
    ButtonStyle? disabledButtonStyle,
    BoxDecoration? containerDecoration,
    BoxDecoration? floatingCardDecoration,
    BoxDecoration? primaryElementDecoration,
    BoxDecoration? secondaryElementDecoration,
    BoxDecoration? tertiaryElementDecoration,
    ToastificationStyle? toastStyle,
  })  : colors = colors ?? SynrgColors.blue(),
        titleTheme = titleTheme ?? const TextTheme(),
        subtitleTheme = subtitleTheme ?? const TextTheme(),
        bodyTheme = bodyTheme ?? const TextTheme(),
        placeholderTheme = placeholderTheme ?? const TextTheme(),
        highlightTheme = highlightTheme ?? const TextTheme(),
        linkTheme = linkTheme ?? const TextTheme(),
        buttonTextTheme = buttonTextTheme ?? const TextTheme(),
        primaryButtonStyle = primaryButtonStyle ?? const ButtonStyle(),
        secondaryButtonStyle = secondaryButtonStyle ?? const ButtonStyle(),
        successButtonStyle = successButtonStyle ?? const ButtonStyle(),
        errorButtonStyle = errorButtonStyle ?? const ButtonStyle(),
        warningButtonStyle = warningButtonStyle ?? const ButtonStyle(),
        confirmButtonStyle = confirmButtonStyle ?? const ButtonStyle(),
        infoButtonStyle = infoButtonStyle ?? const ButtonStyle(),
        disabledButtonStyle = disabledButtonStyle ?? const ButtonStyle(),
        containerDecoration = containerDecoration ?? const BoxDecoration(),
        floatingCardDecoration =
            floatingCardDecoration ?? const BoxDecoration(),
        primaryElementDecoration =
            primaryElementDecoration ?? const BoxDecoration(),
        secondaryElementDecoration =
            secondaryElementDecoration ?? const BoxDecoration(),
        tertiaryElementDecoration =
            tertiaryElementDecoration ?? const BoxDecoration(),
        toastStyle = toastStyle ?? ToastificationStyle.fillColored;

  SynrgColors colors;

  /// Text Themes
  TextTheme titleTheme;
  TextTheme subtitleTheme;
  TextTheme bodyTheme;
  TextTheme placeholderTheme;
  TextTheme highlightTheme;
  TextTheme linkTheme;
  TextTheme buttonTextTheme;

  /// Button Styles
  ButtonStyle primaryButtonStyle;
  ButtonStyle secondaryButtonStyle;
  ButtonStyle successButtonStyle;
  ButtonStyle errorButtonStyle;
  ButtonStyle warningButtonStyle;
  ButtonStyle confirmButtonStyle;
  ButtonStyle infoButtonStyle;
  ButtonStyle disabledButtonStyle;

  /// Container Decoration
  BoxDecoration containerDecoration;
  BoxDecoration floatingCardDecoration;
  BoxDecoration primaryElementDecoration;
  BoxDecoration secondaryElementDecoration;
  BoxDecoration tertiaryElementDecoration;

  ToastificationStyle toastStyle;
}
