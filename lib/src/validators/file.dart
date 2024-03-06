/// Validates if the input string is a valid file name.
/// Returns `null` if valid, or an error message string if invalid.
String? validateFileName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a file name';
  }
  // This regex checks for invalid characters in file names. It's basic
  // and might need adjustments.
  if (RegExp(r'[\\/:*?"<>|]').hasMatch(value)) {
    return 'File name contains invalid characters';
  }
  return null;
}

/// Validates the file extension against a list of allowed extensions.
/// Returns `null` if valid, or an error message string if invalid.
String? validateFileExtension(String? value, List<String> allowedExtensions) {
  if (value == null || value.isEmpty) {
    return 'Please enter a file name';
  }
  final extension = value.split('.').last;
  if (!allowedExtensions.contains(extension)) {
    return 'File extension not allowed';
  }
  return null;
}

/// Validates the file path structure.
/// Returns `null` if valid, or an error message string if invalid.
String? validateFilePath(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a file path';
  }
  // This is a very basic check for a file path structure.
  if (!RegExp(r'^.+/[^/]+$').hasMatch(value)) {
    return 'Enter a valid file path';
  }
  return null;
}

/// Validates if the file size (in bytes) is within a given range. This function
/// would typically be used in conjunction with file selection inputs. The size
/// parameter should represent the file size in bytes. Returns `null` if valid,
/// or an error message string if invalid.
String? validateFileSize(int size, int minSize, int maxSize) {
  if (size < minSize) {
    return 'File is too small';
  }
  if (size > maxSize) {
    return 'File is too large';
  }
  return null;
}
