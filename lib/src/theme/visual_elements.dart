// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';

///
class VisualElements {
  VisualElements({
    this.card = const BoxDecoration(),
    this.primary = const BoxDecoration(),
    this.secondary = const BoxDecoration(),
    this.tertiary = const BoxDecoration(),
  });
  BoxDecoration card;
  BoxDecoration primary;
  BoxDecoration secondary;
  BoxDecoration tertiary;
}
