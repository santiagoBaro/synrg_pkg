/// Validates a Student ID.
/// Returns `null` if valid, or an error message string if invalid.
String? validateStudentID(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a student ID';
  }
  // Basic alphanumeric check, adjust regex as needed for specific ID formats.
  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
    return 'Enter a valid student ID';
  }
  return null;
}

/// Validates an Employee ID.
/// Returns `null` if valid, or an error message string if invalid.
String? validateEmployeeID(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an employee ID';
  }
  // Basic alphanumeric check, can be customized for specific ID formats.
  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
    return 'Enter a valid employee ID';
  }
  return null;
}

/// Validates a Job Position.
/// This function checks for non-empty input as job positions can vary widely.
/// Returns `null` if valid, or an error message string if invalid.
String? validateJobPosition(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a job position';
  }
  return null;
}

/// Validates a Department Code.
/// Returns `null` if valid, or an error message string if invalid.
String? validateDepartmentCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a department code';
  }
  // Basic alphanumeric check, adjust according to specific format requirements.
  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
    return 'Enter a valid department code';
  }
  return null;
}

/// Validates a Course Code.
/// Returns `null` if valid, or an error message string if invalid.
String? validateCourseCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a course code';
  }
  // Basic alphanumeric and potentially hyphen/underscore check.
  if (!RegExp(r'^[A-Z0-9-_]+$').hasMatch(value)) {
    return 'Enter a valid course code';
  }
  return null;
}

/// Validates a Grade Level.
/// Returns `null` if valid, or an error message string if invalid.
String? validateGradeLevel(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a grade level';
  }
  // Numeric check, adjust range as needed.
  final level = int.tryParse(value);
  if (level == null || level < 1 || level > 12) {
    // Assuming K-12 system, adjust as necessary.
    return 'Enter a valid grade level (1-12)';
  }
  return null;
}

/// Validates a GPA (Grade Point Average).
/// Returns `null` if valid, or an error message string if invalid.
String? validateGPA(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a GPA';
  }
  final gpa = double.tryParse(value);
  if (gpa == null || gpa < 0.0 || gpa > 4.0) {
    // Adjust max GPA if your system uses a different scale.
    return 'Enter a valid GPA (0.0-4.0)';
  }
  return null;
}
