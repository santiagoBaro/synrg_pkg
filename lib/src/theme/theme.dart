// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:synrg/synrg.dart';
import 'package:toastification/toastification.dart';

export 'button.dart';
export 'colors.dart';
export 'form_field.dart';
export 'size.dart';
export 'text.dart';
export 'visual_elements.dart';

SynrgTheme synrgTheme = SynrgTheme();

class SynrgTheme {
  SynrgTheme({
    SynrgColors? colors,
    SynrgTextTheme? text,
    SynrgButtonTheme? button,
    ToastificationStyle? toastStyle,
    VisualElements? visualElements,
  })  : colors = colors ?? SynrgColors.blue(),
        text = text ?? baseTextStyle,
        button = button ?? baseButtonStyle,
        visualElements = visualElements ?? baseVisualElements,
        toastStyle = toastStyle ?? ToastificationStyle.fillColored;

  final SynrgColors colors;
  final SynrgTextTheme text;
  final SynrgButtonTheme button;
  final VisualElements visualElements;
  final ToastificationStyle toastStyle;
}

final baseButtonStyle = SynrgButtonTheme(
  primary: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.blue),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    textStyle:
        WidgetStateProperty.all(const TextStyle(fontWeight: FontWeight.bold)),
  ),
  secondary: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.lightBlue),
    foregroundColor: WidgetStateProperty.all(Colors.white),
  ),
  success: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.green),
    foregroundColor: WidgetStateProperty.all(Colors.white),
  ),
  error: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.red),
    foregroundColor: WidgetStateProperty.all(Colors.white),
  ),
  warning: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.orange),
    foregroundColor: WidgetStateProperty.all(Colors.black),
  ),
  confirm: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.teal),
    foregroundColor: WidgetStateProperty.all(Colors.white),
  ),
  info: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.lightBlue),
    foregroundColor: WidgetStateProperty.all(Colors.white),
  ),
  disabled: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.grey.shade300),
    foregroundColor: WidgetStateProperty.all(Colors.grey.shade600),
  ),
);

final baseVisualElements = VisualElements(
  card: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  primary: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
  ),
  secondary: BoxDecoration(
    color: Colors.lightBlue,
    borderRadius: BorderRadius.circular(12),
  ),
  tertiary: BoxDecoration(
    color: Colors.cyan,
    borderRadius: BorderRadius.circular(12),
  ),
);

final baseTextStyle = SynrgTextTheme(
  title: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  subtitle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  ),
  body: const TextStyle(
    fontSize: 16,
    color: Colors.black54,
  ),
  placeholder: const TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.italic,
    color: Colors.grey,
  ),
  highlight: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.blueAccent,
  ),
  link: const TextStyle(
    fontSize: 16,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  ),
  button: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
);
