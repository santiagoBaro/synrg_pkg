// ignore_for_file: public_member_api_docs
import 'package:synrg/src/theme/button.dart';
import 'package:synrg/src/theme/colors.dart';
import 'package:synrg/src/theme/text.dart';
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
        text = text ?? SynrgTextTheme(),
        button = button ?? SynrgButtonTheme(),
        visualElements = visualElements ?? VisualElements(),
        toastStyle = toastStyle ?? ToastificationStyle.fillColored;

  final SynrgColors colors;
  final SynrgTextTheme text;
  final SynrgButtonTheme button;
  final VisualElements visualElements;
  final ToastificationStyle toastStyle;
}
