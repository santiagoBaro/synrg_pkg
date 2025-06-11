import 'package:cloud_firestore/cloud_firestore.dart';

/// Parse a date from a dynamic value.
DateTime parseDate(dynamic value) {
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
  if (value is DateTime) return value;
  return DateTime.now();
}
