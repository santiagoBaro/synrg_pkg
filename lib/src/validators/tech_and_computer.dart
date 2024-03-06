/// Validates a URL.
/// Returns `null` if valid, or an error message string if invalid.
String? validateURL(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a URL';
  }
  if (!RegExp(r'^https?:\/\/[^\s$.?#].[^\s]*$').hasMatch(value)) {
    return 'Enter a valid URL';
  }
  return null;
}

/// Validates a Domain Name.
/// Returns `null` if valid, or an error message string if invalid.
String? validateDomainName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a domain name';
  }
  if (!RegExp(
    r'^(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}$',
  ).hasMatch(value)) {
    return 'Enter a valid domain name';
  }
  return null;
}

/// Validates an IPv4 Address.
/// Returns `null` if valid, or an error message string if invalid.
String? validateIPv4Address(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an IPv4 address';
  }
  if (!RegExp(r'^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$').hasMatch(value)) {
    return 'Enter a valid IPv4 address';
  }
  return null;
}

/// Validates an IPv6 Address.
/// Returns `null` if valid, or an error message string if invalid.
String? validateIPv6Address(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an IPv6 address';
  }
  // This is a simplified check; IPv6 validation can be more complex
  if (!RegExp(r'^\s*([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}\s*$')
      .hasMatch(value)) {
    return 'Enter a valid IPv6 address';
  }
  return null;
}

/// Validates a MAC Address.
/// Returns `null` if valid, or an error message string if invalid.
String? validateMACAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a MAC address';
  }
  if (!RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$').hasMatch(value)) {
    return 'Enter a valid MAC address';
  }
  return null;
}

/// Validates the Local Part of an Email.
/// Returns `null` if valid, or an error message string if invalid.
String? validateEmailLocalPart(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the local part of an email';
  }
  // This is a basic check; specific rules can be more complex
  if (!RegExp(r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+$').hasMatch(value)) {
    return 'Enter a valid local part of an email';
  }
  return null;
}

/// Validates a Username for Social Media.
/// Returns `null` if valid, or an error message string if invalid.
String? validateUsernameSocialMedia(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a username';
  }
  if (!RegExp(r'^[a-zA-Z0-9._]{3,}$').hasMatch(value)) {
    return 'Enter a valid username';
  }
  return null;
}

/// Validates Password Strength.
/// Returns `null` if valid, or an error message string if invalid.
String? validatePasswordStrength(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  // Example: At least one uppercase, one lowercase, one digit, and 8 chars long
  if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$')
      .hasMatch(value)) {
    // ignore: lines_longer_than_80_chars
    return 'Password must contain at least 8 characters, including upper and lower case letters and a number';
  }
  return null;
}

/// Validates Password Confirmation.
/// Compares two passwords for equality.
/// Returns `null` if valid, or an error message string if invalid.
String? validatePasswordConfirmation(
  String? password,
  String? confirmPassword,
) {
  if (password == null ||
      confirmPassword == null ||
      password.isEmpty ||
      confirmPassword.isEmpty) {
    return 'Passwords cannot be empty';
  }
  if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  return null;
}

/// Validates an API Key.
/// Returns `null` if valid, or an error message string if invalid.
String? validateAPIKey(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an API key';
  }
  // Basic check for API key format (adjust based on expected format)
  if (!RegExp(r'^[a-zA-Z0-9]{32,}$').hasMatch(value)) {
    return 'Enter a valid API key';
  }
  return null;
}

/// Validates a UUID (Universally Unique Identifier).
/// Returns `null` if valid, or an error message string if invalid.
String? validateUUID(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a UUID';
  }
  if (!RegExp(
    // ignore: lines_longer_than_80_chars
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
  ).hasMatch(value)) {
    return 'Enter a valid UUID';
  }
  return null;
}

/// Validates a HEX Color Code.
/// Returns `null` if valid, or an error message string if invalid.
String? validateHEXColorCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a HEX color code';
  }
  if (!RegExp(r'^#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$').hasMatch(value)) {
    return 'Enter a valid HEX color code';
  }
  return null;
}

/// Validates an RFID Tag.
/// Returns `null` if valid, or an error message string if invalid.
String? validateRFIDTag(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an RFID tag';
  }
  // RFID tags can vary greatly, so this is a basic length check.
  if (value.length < 7 || value.length > 24) {
    return 'Enter a valid RFID tag length';
  }
  return null;
}

/// Validates a Barcode.
/// Returns `null` if valid, or an error message string if invalid.
String? validateBarcode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a barcode';
  }
  // Basic numeric check, specific formats (e.g., EAN, UPC) require
  //more specific validation.
  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'Enter a valid barcode (numeric values only)';
  }
  return null;
}

/// Validates a QR Code.
/// Returns `null` if valid, or an error message string if invalid.
String? validateQRCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a QR code data';
  }
  // This is a very basic check since QR codes can encode various types of data.
  // A more thorough validation would depend on the expected format of the data
  // encoded in the QR code.
  if (value.isEmpty) {
    return 'Enter valid QR code data';
  }
  return null;
}
