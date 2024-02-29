/// Validates a Street Address.
/// Returns `null` if valid, or an error message string if invalid.
String? validateStreetAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a street address';
  }
  // Basic check for length, adjust regex for more specific needs
  if (value.length < 4) {
    return 'Enter a valid street address';
  }
  return null;
}

/// Validates a City Name.
/// Returns `null` if valid, or an error message string if invalid.
String? validateCity(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a city name';
  }
  // Basic validation for city names, can be expanded based on specific requirements
  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return 'Enter a valid city name';
  }
  return null;
}

/// Validates a State or Province Name.
/// Returns `null` if valid, or an error message string if invalid.
String? validateStateProvince(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a state or province';
  }
  // Basic validation, adjust regex or logic for specific country requirements
  if (value.length < 2) {
    return 'Enter a valid state or province';
  }
  return null;
}

/// Validates a Country Name.
/// Returns `null` if valid, or an error message string if invalid.
String? validateCountry(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a country name';
  }
  // Consider using a predefined list of countries for validation
  return null;
}

/// Validates a ZIP or Postal Code.
/// Returns `null` if valid, or an error message string if invalid.
String? validateZipPostalCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a ZIP or postal code';
  }
  // Basic regex for US ZIP codes, adjust for international formats as needed
  if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(value)) {
    return 'Enter a valid ZIP or postal code';
  }
  return null;
}

/// Validates Latitude and Longitude.
/// Returns `null` if valid, or an error message string if invalid.
String? validateLatitudeLongitude(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter latitude and longitude';
  }
  // Basic check for latitude and longitude format
  if (!RegExp(
          r'^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$')
      .hasMatch(value)) {
    return 'Enter a valid latitude and longitude';
  }
  return null;
}

/// Validates a ZIP+4 Code.
/// Returns `null` if valid, or an error message string if invalid.
String? validateZIPPlus4(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a ZIP+4 Code';
  }
  if (!RegExp(r'^\d{5}-\d{4}$').hasMatch(value)) {
    return 'Enter a valid ZIP+4 Code (e.g., 12345-6789)';
  }
  return null;
}
