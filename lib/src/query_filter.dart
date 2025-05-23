// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// Represents a filter for querying data in a database.
@immutable
class QueryFilter {
  QueryFilter(
    this.field, {
    this.isEqualTo,
    this.isNotEqualTo,
    this.isLessThan,
    this.isLessThanOrEqualTo,
    this.isGreaterThan,
    this.isGreaterThanOrEqualTo,
    this.arrayContains,
    this.arrayContainsAny,
    this.whereIn,
    this.whereNotIn,
    this.isNull,
  }) {
    _assertValidState();
  }

  /// name of the field to filter on
  final String field;
  final dynamic isEqualTo;
  final dynamic isNotEqualTo;
  final dynamic isLessThan;
  final dynamic isLessThanOrEqualTo;
  final dynamic isGreaterThan;
  final dynamic isGreaterThanOrEqualTo;
  final dynamic arrayContains;
  final List<dynamic>? arrayContainsAny;
  final List<dynamic>? whereIn;
  final List<dynamic>? whereNotIn;
  final bool? isNull;

  void _assertValidState() {
    final conditions = [
      isEqualTo,
      isNotEqualTo,
      isLessThan,
      isLessThanOrEqualTo,
      isGreaterThan,
      isGreaterThanOrEqualTo,
      arrayContains,
      arrayContainsAny,
      whereIn,
      whereNotIn,
      isNull,
    ];
    final setConditions = conditions.where((c) => c != null).length;
    assert(field.isNotEmpty, 'QueryFilter field cannot be empty.');
    assert(
      setConditions == 1,
      'QueryFilter must have exactly one condition set. Found $setConditions for field "$field".',
    );
  }

  static const Map<String, String> _parameterToOperator = {
    'isEqualTo': '=',
    'isNotEqualTo': '!=',
    'isLessThan': '<',
    'isLessThanOrEqualTo': '<=',
    'isGreaterThan': '>',
    'isGreaterThanOrEqualTo': '>=',
    'arrayContains': 'arrayContains',
    'arrayContainsAny': 'arrayContainsAny',
    'whereIn': 'in',
    'whereNotIn': 'not-in',
    'isNull': 'isNull',
  };

  static bool _isTextOperator(String operatorSymbol) {
    return operatorSymbol.contains(RegExp('[a-zA-Z]'));
  }

  @override
  String toString() {
    String? operatorSymbol;
    dynamic value;

    if (isEqualTo != null) {
      operatorSymbol = _parameterToOperator['isEqualTo'];
      value = isEqualTo;
    } else if (isNotEqualTo != null) {
      operatorSymbol = _parameterToOperator['isNotEqualTo'];
      value = isNotEqualTo;
    } else if (isLessThan != null) {
      operatorSymbol = _parameterToOperator['isLessThan'];
      value = isLessThan;
    } else if (isLessThanOrEqualTo != null) {
      operatorSymbol = _parameterToOperator['isLessThanOrEqualTo'];
      value = isLessThanOrEqualTo;
    } else if (isGreaterThan != null) {
      operatorSymbol = _parameterToOperator['isGreaterThan'];
      value = isGreaterThan;
    } else if (isGreaterThanOrEqualTo != null) {
      operatorSymbol = _parameterToOperator['isGreaterThanOrEqualTo'];
      value = isGreaterThanOrEqualTo;
    } else if (arrayContains != null) {
      operatorSymbol = _parameterToOperator['arrayContains'];
      value = arrayContains;
    } else if (arrayContainsAny != null) {
      operatorSymbol = _parameterToOperator['arrayContainsAny'];
      value = arrayContainsAny;
    } else if (whereIn != null) {
      operatorSymbol = _parameterToOperator['whereIn'];
      value = whereIn;
    } else if (whereNotIn != null) {
      operatorSymbol = _parameterToOperator['whereNotIn'];
      value = whereNotIn;
    } else if (isNull != null) {
      operatorSymbol = _parameterToOperator['isNull'];
      value = isNull;
    } else {
      throw StateError(
        'Invalid QueryFilter state: No condition set for field "$field".',
      );
    }

    final formattedValue = _formatValueForString(value);
    final operatorString =
        _isTextOperator(operatorSymbol!) ? ' $operatorSymbol ' : operatorSymbol;

    return '$field$operatorString$formattedValue';
  }

  static String _formatValueForString(dynamic value) {
    if (value is String) {
      if (value
          .contains(RegExp(r'[\s\[\],=<>!]|arrayContains|in|not-in|isNull'))) {
        final escaped = value.replaceAll('"', r'\"');
        return '"$escaped"';
      }
      return value;
    } else if (value is List) {
      return '[${value.map(_formatValueForString).join(',')}]';
    } else {
      return value.toString();
    }
  }

  static QueryFilter fromString(String segment) {
    final querySegment = segment.trim();
    if (querySegment.isEmpty) {
      throw const FormatException(
        'Cannot create QueryFilter from empty string.',
      );
    }

    const operatorSymbols = <String>[
      '!=',
      '>=',
      '<=',
      ' arrayContainsAny ',
      ' arrayContains ',
      ' not-in ',
      ' in ',
      ' isNull ',
      '=',
      '>',
      '<',
    ];

    for (final opSymbolTrimmed in operatorSymbols) {
      final opSymbol = opSymbolTrimmed;
      final opIndex = querySegment.indexOf(opSymbol);

      if (opIndex != -1) {
        final field = querySegment.substring(0, opIndex).trim();
        final valueString =
            querySegment.substring(opIndex + opSymbol.length).trim();

        if (field.isEmpty) {
          throw FormatException(
            'Field cannot be empty in query segment: "$querySegment"',
          );
        }

        final opLogicKey = opSymbolTrimmed.trim();

        if (opLogicKey == 'isNull') {
          final boolValue = valueString.toLowerCase() == 'true';
          if (valueString.toLowerCase() != 'true' &&
              valueString.toLowerCase() != 'false') {
            throw FormatException(
              'Invalid boolean value for isNull: "$valueString" in "$querySegment"',
            );
          }
          return QueryFilter(field, isNull: boolValue);
        }

        if (valueString.isEmpty) {
          throw FormatException(
            'Value cannot be empty for operator "$opLogicKey" in query segment: "$querySegment"',
          );
        }

        final dynamic parsedValue =
            _parseValueFromString(valueString, opLogicKey);

        switch (opLogicKey) {
          case '=':
            return QueryFilter(field, isEqualTo: parsedValue);
          case '!=':
            return QueryFilter(field, isNotEqualTo: parsedValue);
          case '>=':
            return QueryFilter(field, isGreaterThanOrEqualTo: parsedValue);
          case '<=':
            return QueryFilter(field, isLessThanOrEqualTo: parsedValue);
          case '>':
            return QueryFilter(field, isGreaterThan: parsedValue);
          case '<':
            return QueryFilter(field, isLessThan: parsedValue);
          case 'arrayContains':
            return QueryFilter(field, arrayContains: parsedValue);
          case 'in':
            if (parsedValue is List) {
              return QueryFilter(field, whereIn: parsedValue);
            }
            throw FormatException(
              'Parsed value for "in" is not a List: "$valueString"',
            );
          case 'not-in':
            if (parsedValue is List) {
              return QueryFilter(field, whereNotIn: parsedValue);
            }
            throw FormatException(
              'Parsed value for "not-in" is not a List: "$valueString"',
            );
          case 'arrayContainsAny':
            if (parsedValue is List) {
              return QueryFilter(field, arrayContainsAny: parsedValue);
            }
            throw FormatException(
              'Parsed value for "arrayContainsAny" is not a List: "$valueString"',
            );
          default:
            throw FormatException(
              'Internal error: Unhandled operator symbol "$opLogicKey" found during parsing.',
            );
        }
      }
    }
    throw FormatException(
      'No valid operator found in query segment: "$querySegment"',
    );
  }

  static dynamic _parseValueFromString(
    String valueString,
    String operatorSymbol,
  ) {
    if (valueString.startsWith('"') && valueString.endsWith('"')) {
      return valueString
          .substring(1, valueString.length - 1)
          .replaceAll(r'\"', '"');
    }

    if (['in', 'not-in', 'arrayContainsAny'].contains(operatorSymbol)) {
      if (valueString.startsWith('[') && valueString.endsWith(']')) {
        final listContent = valueString.substring(1, valueString.length - 1);
        if (listContent.isEmpty) return <dynamic>[];
        return listContent
            .split(',')
            .map((s) => _parseValueFromString(s.trim(), ''))
            .toList();
      } else {
        throw FormatException(
          'Invalid list format for operator "$operatorSymbol": "$valueString"',
        );
      }
    }

    if (valueString.toLowerCase() == 'true') return true;
    if (valueString.toLowerCase() == 'false') return false;
    if (valueString.toLowerCase() == 'null') return null;

    final intValue = int.tryParse(valueString);
    if (intValue != null) return intValue;

    final doubleValue = double.tryParse(valueString);
    if (doubleValue != null) return doubleValue;

    return valueString;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueryFilter &&
          runtimeType == other.runtimeType &&
          field == other.field &&
          const DeepCollectionEquality().equals(isEqualTo, other.isEqualTo) &&
          const DeepCollectionEquality()
              .equals(isNotEqualTo, other.isNotEqualTo) &&
          const DeepCollectionEquality().equals(isLessThan, other.isLessThan) &&
          const DeepCollectionEquality()
              .equals(isLessThanOrEqualTo, other.isLessThanOrEqualTo) &&
          const DeepCollectionEquality()
              .equals(isGreaterThan, other.isGreaterThan) &&
          const DeepCollectionEquality()
              .equals(isGreaterThanOrEqualTo, other.isGreaterThanOrEqualTo) &&
          const DeepCollectionEquality()
              .equals(arrayContains, other.arrayContains) &&
          const DeepCollectionEquality()
              .equals(arrayContainsAny, other.arrayContainsAny) &&
          const DeepCollectionEquality().equals(whereIn, other.whereIn) &&
          const DeepCollectionEquality().equals(whereNotIn, other.whereNotIn) &&
          const DeepCollectionEquality().equals(isNull, other.isNull);

  @override
  int get hashCode =>
      field.hashCode ^
      const DeepCollectionEquality().hash(isEqualTo) ^
      const DeepCollectionEquality().hash(isNotEqualTo) ^
      const DeepCollectionEquality().hash(isLessThan) ^
      const DeepCollectionEquality().hash(isLessThanOrEqualTo) ^
      const DeepCollectionEquality().hash(isGreaterThan) ^
      const DeepCollectionEquality().hash(isGreaterThanOrEqualTo) ^
      const DeepCollectionEquality().hash(arrayContains) ^
      const DeepCollectionEquality().hash(arrayContainsAny) ^
      const DeepCollectionEquality().hash(whereIn) ^
      const DeepCollectionEquality().hash(whereNotIn) ^
      const DeepCollectionEquality().hash(isNull);
}
