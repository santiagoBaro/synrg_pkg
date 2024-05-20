import 'package:flutter/material.dart';
import 'package:synrg/synrg.dart';

///
class SynrgFormField {
  ///
  static Widget phone(void Function(String)? onChanged) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      validator: validatePhoneNumber,
      onChanged: onChanged,
    );
  }
}
