/// Validates a Language Code according to ISO 639-1.
/// Returns `null` if valid, or an error message string if invalid.
String? validateLanguageCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a language code';
  }
  if (!RegExp(r'^[a-z]{2}$').hasMatch(value.toLowerCase())) {
    return 'Enter a valid 2-letter ISO 639-1 language code';
  }
  return null;
}

/// Validates a Country Code according to ISO 3166-1 alpha-2.
/// Returns `null` if valid, or an error message string if invalid.
String? validateCountryCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a country code';
  }
  if (!RegExp(r'^[A-Z]{2}$').hasMatch(value.toUpperCase())) {
    return 'Enter a valid 2-letter ISO 3166-1 alpha-2 country code';
  }
  return null;
}

/// Validates a Currency Code according to ISO 4217.
/// Returns `null` if valid, or an error message string if invalid.
String? validateCurrencyCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a currency code';
  }
  if (!RegExp(r'^[A-Z]{3}$').hasMatch(value.toUpperCase())) {
    return 'Enter a valid 3-letter ISO 4217 currency code';
  }
  return null;
}

/// Validates Vehicle Make and Model.
/// This function checks for non-empty input as formats can vary widely.
/// Returns `null` if valid, or an error message string if invalid.
String? validateVehicleMakeAndModel(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the vehicle make and model';
  }
  return null;
}

/// Validates an Aircraft Tail Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateAircraftTailNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an aircraft tail number';
  }
  // Basic alphanumeric check, adjust regex as needed for specific formats.
  if (!RegExp(r'^[A-Z0-9-]+$').hasMatch(value.toUpperCase())) {
    return 'Enter a valid aircraft tail number';
  }
  return null;
}

/// Validates a Shipping Tracking Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateShippingTrackingNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a shipping tracking number';
  }
  // Example validation, adjust as necessary for specific carrier formats.
  return null;
}

/// Validates a Container Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateContainerNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a container number';
  }
  // Example validation for container numbers (format varies).
  return null;
}

/// Validates Hazardous Materials Code.
/// Returns `null` if valid, or an error message string if invalid.
String? validateHazardousMaterialsCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a hazardous materials code';
  }
  // Hazardous materials codes vary; adjust validation as needed.
  return null;
}

/// Validates Military Rank.
/// Returns `null` if valid, or an error message string if invalid.
String? validateMilitaryRank(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a military rank';
  }
  // Example validation, adjust as necessary for rank formats.
  return null;
}

/// Validates Political District.
/// Returns `null` if valid, or an error message string if invalid.
String? validatePoliticalDistrict(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a political district';
  }
  // Example validation, adjust as necessary for district formats.
  return null;
}
