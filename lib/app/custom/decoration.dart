import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration({
    required BuildContext context,
    String labelText = "",
    String helperText = "",
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    InputBorder? border,
    bool? isDense,
  }) : super(
    labelText: labelText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    isDense: isDense,
    helperText: helperText,
    errorText: errorText,
    filled: Theme.of(context).brightness == Brightness.dark,  
    border: border ?? (Theme.of(context).brightness == Brightness.dark ? null : const OutlineInputBorder()),
  );
}