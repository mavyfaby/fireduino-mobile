import 'dart:convert';

/// Base64 encode a string
String tb64(String text) {
  return base64Encode(utf8.encode(text)).replaceAll("=", "");
}

/// Base64 decode a string
String rb64(String text) {
  return utf8.decode(base64Decode(text));
}