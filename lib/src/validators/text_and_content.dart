import 'dart:convert';

/// Validates if the input string is plain text without any specific format.
/// This function is quite permissive, as plain text can include nearly
///  anything.Returns `null` if valid, or an error message string if invalid.
String? validatePlainText(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

/// Validates if the input string is rich text, typically containing
/// formatting such as HTML. This is a basic check and might need to be
/// more sophisticated based on your rich text specifications.
String? validateRichText(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter rich text';
  }
  // Basic check for tags indicative of rich text
  if (!RegExp(r'<[a-z][\s\S]*>').hasMatch(value)) {
    return 'Enter valid rich text with formatting tags';
  }
  return null;
}

/// Validates if the input string is a well-formed JSON.
/// Returns `null` if valid, or an error message string if invalid.
String? validateJSONString(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a JSON string';
  }
  try {
    json.decode(value);
    return null;
  } catch (e) {
    return 'Enter a valid JSON string';
  }
}

/// Validates if the input string is a well-formed XML.
/// Returns `null` if valid, or an error message string if invalid.
String? validateXMLString(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an XML string';
  }
  // This is a simplistic check and might not catch all XML errors.
  if (!RegExp(r'^<\?xml[\s\S]+\?>[\s\S]+<\/[a-zA-Z]+>$').hasMatch(value)) {
    return 'Enter a valid XML string';
  }
  return null;
}

/// Validates if the input string is in valid CSV format. This is a basic
/// implementation and might need adjustments for specific CSV rules.
String? validateCSVFormat(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter CSV content';
  }
  // Checks for the presence of comma-separated values in at least one row.
  if (!RegExp(r'^(.+,)+.+$', multiLine: true).hasMatch(value)) {
    return 'Enter valid CSV format';
  }
  return null;
}

/// Validates if the input string is a valid SQL query.
/// This is a very basic check and might not suit all SQL dialects.
String? validateSQLQuery(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an SQL query';
  }
  // Simple check for SELECT/INSERT/UPDATE/DELETE statements.
  if (!RegExp(
    r'^(SELECT|INSERT INTO|UPDATE|DELETE FROM)\s+',
    caseSensitive: false,
  ).hasMatch(value)) {
    return 'Enter a valid SQL query';
  }
  return null;
}

/// Validates if the input string is a valid regular expression.
/// Returns `null` if valid, or an error message string if invalid.
String? validateRegularExpression(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a regular expression';
  }
  try {
    RegExp(value);
    return null;
  } catch (e) {
    return 'Enter a valid regular expression';
  }
}

/// Validates if the input string is valid Markdown content.
/// This function is permissive as Markdown can be plain text
/// with specific symbols.
String? validateMarkdown(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter Markdown content';
  }
  // This is a very basic check for Markdown symbols.
  if (!RegExp(r'(\*|_|#|\[|\]|>|`)+').hasMatch(value)) {
    return 'Enter valid Markdown content';
  }
  return null;
}

/// Validates if the input string is valid HTML content.
/// Returns `null` if valid, or an error message string if invalid.
String? validateHTMLContent(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter HTML content';
  }
  // Basic check for HTML tags.
  if (!RegExp(r'<[a-z][\s\S]*>').hasMatch(value)) {
    return 'Enter valid HTML content';
  }
  return null;
}
