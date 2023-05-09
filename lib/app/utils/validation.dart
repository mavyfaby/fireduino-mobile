/// Validation for MAC Address
bool isMacAddress(String text) {
  // Regex for MAC Address
  RegExp regex = RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
  // Check if the text matches the regex
  return regex.hasMatch(text);
}