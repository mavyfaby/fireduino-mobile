import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration({
    required BuildContext context,
    String labelText = "",
    Widget? prefixIcon,
    Widget? suffixIcon,
    InputBorder? border,
  }) : super(
    labelText: labelText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: Theme.of(context).brightness == Brightness.dark,  
    border: border ?? (Theme.of(context).brightness == Brightness.dark ? null : const OutlineInputBorder()),
  );
}