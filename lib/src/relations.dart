import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synrg/synrg.dart';

/// A Foreign Key relation
class FK<T extends SynrgClass> {
  /// Initializes the FK relation
  FK(String collectionName, this._fromMap, {this.attributes = const []}) {
    _collectionName = collectionName;
    _collection = FirebaseFirestore.instance.collection(collectionName);
  }

  /// parse the data from the map
  T? fromMap(Map<String, dynamic> map) {
    final parsed = _fromMap(map);
    obj = parsed;
    return parsed;
  }

  /// parse the data to the map
  Map<String, dynamic>? toMap(T obj) {
    final map = obj.toMap();
    return _filterMapByAttributes(map, attributes);
  }

  /// Get the object from the database
  Future<T?> get() async {
    try {
      final documentSnapshot = await _collection.doc(obj?.id).get();
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data()! as Map<String, dynamic>;
        return _fromMap(data);
      }
      return null;
    } on Exception catch (e, s) {
      SynrgCrashlytics.instance.logError(
        e as Error,
        s,
        reason: 'FK get exception: $_collectionName',
      );
      return null;
    }
  }

  late String _collectionName;
  late CollectionReference _collection;
  final T Function(Map<String, dynamic>) _fromMap;

  /// The object that will be cached
  late T? obj;

  /// The list of attributes that will be cached
  final List<String> attributes;
}

/// A List of Foreign Key relation
class LFK<T extends SynrgClass> {
  /// Initializes the LFK relation
  LFK(
    String collectionName,
    this._fromMap, {
    this.attributes = const ['*'],
    this.limit = 10,
  }) {
    _collectionName = collectionName;
    _collection = FirebaseFirestore.instance.collection(collectionName);
  }

  // ignore: unused_field
  late String _collectionName;
  // ignore: unused_field
  late CollectionReference _collection;
  final T Function(Map<String, dynamic>) _fromMap;

  /// The list of attributes that will be cached
  final List<String> attributes;

  /// The limit of the cached list
  final int limit;

  /// Get the list of objects from the database
  Future<List<T>?> get() async {
    return null;
  }

  /// parse the data from the map
  List<T>? fromMap(List<Map<String, dynamic>> map) {
    return map.map(_fromMap).toList();
  }

  /// parse the data to the map
  List<Map<String, dynamic>> toMap(List<T> obj) {
    if (limit > 0) {
      return obj
          .take(limit)
          .map((e) => _filterMapByAttributes(e.toMap(), attributes))
          .toList();
    } else {
      return obj
          .map((e) => _filterMapByAttributes(e.toMap(), attributes))
          .toList();
    }
  }
}

Map<String, dynamic> _filterMapByAttributes(
  Map<String, dynamic> originalMap,
  List<String> attributes,
) {
  // Create a new map that only contains the keys in the attributes list
  final filteredMap = <String, dynamic>{};

  for (final key in attributes) {
    if (originalMap.containsKey(key)) {
      filteredMap[key] = originalMap[key];
    }
  }

  return filteredMap;
}
