/// Validates if the input string conforms to the YYYY-MM-DD date format.
/// Returns `null` if valid, or an error message string if invalid.
String? validateDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a date';
  }
  if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
    return 'Enter a date in YYYY-MM-DD format';
  }
  return null;
}

/// Validates if the input string conforms to the HH:MM 24-hour time format.
/// Returns `null` if valid, or an error message string if invalid.
String? validateTimeHHMM(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a time';
  }
  if (!RegExp(r'^([01]\d|2[0-3]):[0-5]\d$').hasMatch(value)) {
    return 'Enter a time in HH:MM 24-hour format';
  }
  return null;
}

/// Validates if the input string conforms to the HH:MM:SS 24-hour time format.
/// Returns `null` if valid, or an error message string if invalid.
String? validateTimeHHMMSS(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a time';
  }
  if (!RegExp(r'^([01]\d|2[0-3]):[0-5]\d:[0-5]\d$').hasMatch(value)) {
    return 'Enter a time in HH:MM:SS 24-hour format';
  }
  return null;
}

/// Validates if the input string is a valid timestamp.
/// Returns `null` if valid, or an error message string if invalid.
String? validateTimestamp(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a timestamp';
  }
  // This simple check allows for a wide range of timestamps.
  // You might need more specific validation depending on your needs.
  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'Enter a valid timestamp';
  }
  return null;
}

/// Validates if the input string is a recognized time zone format.
/// Returns `null` if valid, or an error message string if invalid.
String? validateTimeZone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a time zone';
  }
  // This checks for common time zone formats, adjust as necessary.
  if (!RegExp(r'^[a-zA-Z]+/[a-zA-Z_]+(/[a-zA-Z_]+)?$').hasMatch(value)) {
    return 'Enter a valid time zone';
  }
  return null;
}

/// Validates if the input string is a valid weekday.
/// Returns `null` if valid, or an error message string if invalid.
String? validateWeekday(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a weekday';
  }
  List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  if (!weekdays.contains(value)) {
    return 'Enter a valid weekday';
  }
  return null;
}

/// Validates if the input string is a valid month.
/// Returns `null` if valid, or an error message string if invalid.
String? validateMonth(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a month';
  }
  if (!RegExp(r'^(0?[1-9]|1[012])$').hasMatch(value)) {
    return 'Enter a valid month (1-12)';
  }
  return null;
}

/// Validates if the input string is a valid year.
/// Returns `null` if valid, or an error message string if invalid.
String? validateYear(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a year';
  }
  if (!RegExp(r'^\d{4}$').hasMatch(value)) {
    return 'Enter a valid year (YYYY)';
  }
  return null;
}

/// Validates if the input string is a valid fiscal year.
/// Returns `null` if valid, or an error message string if invalid.
String? validateFiscalYear(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a fiscal year';
  }
  // Fiscal year validation might be similar to regular year, but could be adjusted based on specific fiscal year rules.
  if (!RegExp(r'^\d{4}$').hasMatch(value)) {
    return 'Enter a valid fiscal year (YYYY)';
  }
  return null;
}
