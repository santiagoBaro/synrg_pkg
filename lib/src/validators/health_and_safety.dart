/// Validates a Blood Type.
/// Returns `null` if valid, or an error message string if invalid.
String? validateBloodType(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a blood type';
  }
  if (!RegExp(r'^(A|B|AB|O)[+-]$').hasMatch(value)) {
    return 'Enter a valid blood type (A, B, AB, O, with + or -)';
  }
  return null;
}

/// Validates a Body Mass Index (BMI).
/// Returns `null` if valid, or an error message string if invalid.
String? validateBMI(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a BMI';
  }
  final double? bmi = double.tryParse(value);
  if (bmi == null || bmi <= 0) {
    return 'Enter a valid BMI';
  }
  return null;
}

/// Validates Allergies information.
/// Since allergies can vary widely, this function mainly checks for non-empty input.
/// Returns `null` if valid, or an error message string if invalid.
String? validateAllergies(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter allergies information';
  }
  return null;
}

/// Validates a Medical Record Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateMedicalRecordNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a medical record number';
  }
  // Basic alphanumeric check, adjust according to specific format requirements.
  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
    return 'Enter a valid medical record number';
  }
  return null;
}

/// Validates a Prescription Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validatePrescriptionNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a prescription number';
  }
  // Basic alphanumeric check, adjust as needed.
  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
    return 'Enter a valid prescription number';
  }
  return null;
}

/// Validates a Health Insurance Policy Number.
/// Returns `null` if valid, or an error message string if invalid.
String? validateHealthInsurancePolicyNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a health insurance policy number';
  }
  // Basic alphanumeric check, can be adjusted for format specifics.
  if (!RegExp(r'^[A-Z0-9-]+$').hasMatch(value)) {
    return 'Enter a valid health insurance policy number';
  }
  return null;
}
