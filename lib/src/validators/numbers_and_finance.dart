import 'package:intl/intl.dart';

/// Validates a Credit Card Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateCreditCardNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a credit card number';
  }
  // This is a basic Luhn algorithm check
  if (!_isValidCreditCard(value)) {
    return 'Enter a valid credit card number';
  }
  return null;
}

/// Validates a CVV (Card Verification Value).
/// Returns `null` if valid, or an error message string if invalid.
String? validateCVV(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a CVV';
  }
  if (!RegExp(r'^\d{3,4}$').hasMatch(value)) {
    return 'Enter a valid CVV';
  }
  return null;
}

/// Validates an Expiration Date (MM/YY).
/// Returns `null` if valid, or an error message string if invalid.
String? validateExpirationDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an expiration date';
  }
  if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(value)) {
    return 'Enter a valid expiration date (MM/YY)';
  }
  return null;
}

/// Validates a Bank Account Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateBankAccountNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a bank account number';
  }
  // Basic check, consider more specific validation based on country and bank
  if (value.length < 5) {
    return 'Enter a valid bank account number';
  }
  return null;
}

/// Validates a Routing Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateRoutingNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a routing number';
  }
  // US routing number check, adjust for other countries if necessary
  if (!RegExp(r'^\d{9}$').hasMatch(value)) {
    return 'Enter a valid routing number';
  }
  return null;
}

/// Validates a Tax ID / Social Security Number (SSN).
/// Returns `null` if valid, or an error message string if invalid.
String? validateTaxIDSSN(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a tax ID or SSN';
  }
  // Basic SSN validation
  if (!RegExp(r'^\d{3}-\d{2}-\d{4}$').hasMatch(value)) {
    return 'Enter a valid SSN (XXX-XX-XXXX)';
  }
  return null;
}

/// Validates an IBAN (International Bank Account Number).
/// Returns `null` if valid, or an error message string if invalid.
String? validateIBAN(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an IBAN';
  }
  // Basic check for length and format, specific country formats vary
  if (value.length < 15 || value.length > 34) {
    return 'Enter a valid IBAN';
  }
  return null;
}

/// Validates a BIC / SWIFT Code.
/// Returns `null` if valid, or an error message string if invalid.
String? validateBICSWIFTCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a BIC/SWIFT code';
  }
  // Basic SWIFT/BIC format check
  if (!RegExp(r'^[A-Za-z]{6}[A-Za-z0-9]{2}([A-Za-z0-9]{3})?$')
      .hasMatch(value)) {
    return 'Enter a valid BIC/SWIFT code';
  }
  return null;
}

/// Validates a Currency Format.
/// Returns `null` if valid, or an error message string if invalid.
String? validateCurrencyFormat(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an amount';
  }
  NumberFormat format = NumberFormat.currency(locale: 'en_US', symbol: '');
  try {
    format.parse(value);
    return null;
  } catch (e) {
    return 'Enter a valid currency amount';
  }
}

/// Validates a Percentage.
/// Returns `null` if valid, or an error message string if invalid.
String? validatePercentage(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a percentage';
  }
  final num? percentage = num.tryParse(value);
  if (percentage == null || percentage < 0 || percentage > 100) {
    return 'Enter a valid percentage (0-100)';
  }
  return null;
}

/// Validates a Quantity.
/// Returns `null` if valid, or an error message string if invalid.
String? validateQuantity(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a quantity';
  }
  final int? quantity = int.tryParse(value);
  if (quantity == null || quantity < 0) {
    return 'Enter a valid quantity';
  }
  return null;
}

/// Validates an Order Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateOrderNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an order number';
  }
  // Basic check, adjust as needed
  if (value.length < 3) {
    return 'Enter a valid order number';
  }
  return null;
}

bool _isValidCreditCard(String number) {
  var sum = 0;
  var length = number.length;
  for (var i = 0; i < length; i++) {
    var digit = int.parse(number[length - i - 1]);
    if (i % 2 == 1) {
      digit *= 2;
    }
    sum += digit > 9 ? digit - 9 : digit;
  }
  return sum % 10 == 0;
}
