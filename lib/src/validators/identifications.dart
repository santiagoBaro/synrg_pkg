/// Validates a Vehicle Identification Number (VIN).
/// Returns `null` if valid, or an error message string if invalid.
String? validateVIN(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a VIN';
  }
  if (!RegExp(r'^[A-HJ-NPR-Z0-9]{17}$').hasMatch(value)) {
    return 'Enter a valid 17-character VIN';
  }
  return null;
}

/// Validates a License Plate.
/// This is a basic validation and may need to be adjusted based on country-specific formats.
String? validateLicensePlate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a license plate';
  }
  // Basic alphanumeric check, adjust according to specific format requirements.
  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
    return 'Enter a valid license plate';
  }
  return null;
}

/// Validates a National Identification Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateNationalID(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a national identification number';
  }
  // Adjust the pattern based on the country's ID formatting rules.
  return null; // Placeholder for specific validation logic.
}

/// Validates a Passport Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validatePassportNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a passport number';
  }
  // Simple alphanumeric check, specific formats can vary by country.
  if (!RegExp(r'^[A-Z0-9]{6,9}$').hasMatch(value)) {
    return 'Enter a valid passport number';
  }
  return null;
}

/// Validates a Driver's License Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateDriversLicenseNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a driver\'s license number';
  }
  // This is a basic validation, adjust according to the specific country or state format.
  return null; // Placeholder for specific validation logic.
}

/// Validates a Product SKU (Stock Keeping Unit).
/// Returns `null` if valid, or an error message string if invalid.
String? validateProductSKU(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a product SKU';
  }
  // Basic alphanumeric check.
  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
    return 'Enter a valid product SKU';
  }
  return null;
}

/// Validates an ISBN (International Standard Book Number).
/// Returns `null` if valid, or an error message string if invalid.
String? validateISBN(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an ISBN';
  }
  // Check for ISBN-10 or ISBN-13 format.
  if (!RegExp(r'^(97(8|9))?\d{9}(\d|X)$').hasMatch(value)) {
    return 'Enter a valid ISBN';
  }
  return null;
}

/// Validates an ISSN (International Standard Serial Number).
/// Returns `null` if valid, or an error message string if invalid.
String? validateISSN(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an ISSN';
  }
  // ISSN format check.
  if (!RegExp(r'^\d{4}-\d{3}[\dX]$').hasMatch(value)) {
    return 'Enter a valid ISSN';
  }
  return null;
}

/// Validates a Patent Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validatePatentNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a patent number';
  }
  // Basic validation, actual format can vary widely.
  return null; // Placeholder for specific validation logic.
}

/// Validates a Trademark Serial.
/// Returns `null` if valid, or an error message string if invalid.
String? validateTrademarkSerial(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a trademark serial';
  }
  // Placeholder for basic validation.
  return null; // Placeholder for specific validation logic.
}

/// Validates a Coupon Code.
/// Returns `null` if valid, or an error message string if invalid.
String? validateCouponCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a coupon code';
  }
  // Basic alphanumeric check.
  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
    return 'Enter a valid coupon code';
  }
  return null;
}

/// Validates a Gift Card Code.
/// Returns `null` if valid, or an error message string if invalid.
String? validateGiftCardCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a gift card code';
  }
  // Basic alphanumeric and dash check.
  if (!RegExp(r'^[A-Z0-9-]+$').hasMatch(value)) {
    return 'Enter a valid gift card code';
  }
  return null;
}

/// Validates a Loyalty Card Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateLoyaltyCardNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a loyalty card number';
  }
  // Basic alphanumeric check.
  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
    return 'Enter a valid loyalty card number';
  }
  return null;
}

/// Validates a Ticket Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateTicketNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a ticket number';
  }
  // Basic alphanumeric check.
  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
    return 'Enter a valid ticket number';
  }
  return null;
}

/// Validates an Uruguayan Identification Number (Cédula de Identidad).
/// Returns `null` if valid, or an error message string if invalid.
String? validateUruguayanID(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an Uruguayan ID';
  }
  // Basic alphanumeric check specific to Uruguayan IDs.
  if (!RegExp(r'^[0-9]{8}$').hasMatch(value)) {
    return 'Enter a valid Uruguayan ID';
  }
  return null;
}

/// Validates an Argentinian National Identification Document (Documento Nacional de Identidad).
/// Returns `null` if valid, or an error message string if invalid.
String? validateArgentinianDNI(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an Argentinian DNI';
  }
  // Basic alphanumeric check specific to Argentinian DNIs.
  if (!RegExp(r'^[0-9]{7,8}$').hasMatch(value)) {
    return 'Enter a valid Argentinian DNI';
  }
  return null;
}
