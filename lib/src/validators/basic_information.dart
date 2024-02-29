/// Validates an Email Address.
/// Returns `null` if valid, or an error message string if invalid.
String? validateEmailAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email address';
  }
  final regex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

/// Validates a Phone Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  }
  final regex = RegExp(r'^\+?\d{10,15}$');
  if (!regex.hasMatch(value)) {
    return 'Enter a valid phone number';
  }
  return null;
}

/// Validates a Username.
/// Returns `null` if valid, or an error message string if invalid.
String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a username';
  }
  final regex = RegExp(r'^[a-zA-Z0-9._-]{3,20}$');
  if (!regex.hasMatch(value)) {
    return 'Username must be 3-20 characters long and can include letters, numbers, dots, dashes, and underscores';
  }
  return null;
}

/// Validates a Password.
/// Returns `null` if valid, or an error message string if invalid.
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}

/// Validates a First Name.
/// Returns `null` if valid, or an error message string if invalid.
String? validateFirstName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a first name';
  }
  return null;
}

/// Validates a Last Name.
/// Returns `null` if valid, or an error message string if invalid.
String? validateLastName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a last name';
  }
  return null;
}

/// Validates a Full Name.
/// Returns `null` if valid, or an error message string if invalid.
String? validateFullName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a full name';
  }
  if (!RegExp(r'^[a-zA-Z]+(([\\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$')
      .hasMatch(value)) {
    return 'Enter a valid full name';
  }
  return null;
}

/// Validates a Date of Birth.
/// Returns `null` if valid, or an error message string if invalid.
String? validateDateOfBirth(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your date of birth';
  }
  if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
    return 'Enter a valid date of birth in YYYY-MM-DD format';
  }
  return null;
}

/// Validates an Age.
/// Returns `null` if valid, or an error message string if invalid.
String? validateAge(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your age';
  }
  final int? age = int.tryParse(value);
  if (age == null || age < 0 || age > 120) {
    return 'Enter a valid age (0-120)';
  }
  return null;
}
