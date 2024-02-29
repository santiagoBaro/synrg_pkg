import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synrg/src/class.dart';

/// Firestore Wrapper, get and set given a "collectionName"
class Indexer<T extends SynrgClass> {
  /// Initializes the indexer for the given collection
  Indexer(String collectionName, this._fromMap) {
    _collection = FirebaseFirestore.instance.collection(collectionName);
  }

  late CollectionReference _collection;
  final T Function(Map<String, dynamic>) _fromMap;

  /// Get data by id
  Future<T?> get(String id) async {
    final documentSnapshot = await _collection.doc(id).get();
    if (documentSnapshot.exists) {
      final data = documentSnapshot.data()! as Map<String, dynamic>;
      data['id'] = id;
      return _fromMap(data);
    }
    return null;
  }

  /// Persist the changes in Fire Store
  Future<T> save(T obj) async {
    final data = _toMap(obj);
    if (data['id'].toString() == '') {
      final response = await _collection.add(data);
      data['id'] = response.id;
    } else {
      await _collection.doc(data['id'].toString()).set(data);
    }
    return obj;
  }

  /// Batch get a list of ids
  Future<List<T>> batchGet(List<String> ids) async {
    final querySnapshot = await _collection
        .where(
          FieldPath.documentId,
          whereIn: ids,
        )
        .get();

    final filteredData = <T>[];
    for (final doc in querySnapshot.docs) {
      if (doc.data() != null) {
        final data = doc.data()! as Map<String, dynamic>;
        data['id'] = doc.id;
        final e = _fromMap(data);
        filteredData.add(e);
      }
    }
    return filteredData;
  }

  /// Paginated query method
  Future<List<T>> query({
    required String field,
    dynamic isEqualTo,
    dynamic isNotEqualTo,
    dynamic isLessThan,
    dynamic isLessThanOrEqualTo,
    dynamic isGreaterThan,
    dynamic isGreaterThanOrEqualTo,
    dynamic arrayContains,
    List<dynamic>? arrayContainsAny,
    List<dynamic>? whereIn,
    List<dynamic>? whereNotIn,
    bool? isNull,
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) async {
    var query = _collection
        .where(
          field,
          isEqualTo: isEqualTo,
          isNotEqualTo: isNotEqualTo,
          isLessThan: isLessThan,
          isLessThanOrEqualTo: isLessThanOrEqualTo,
          isGreaterThan: isGreaterThan,
          isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
          arrayContains: arrayContains,
          arrayContainsAny: arrayContainsAny,
          whereIn: whereIn,
          whereNotIn: whereNotIn,
          isNull: isNull,
        )
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final querySnapshot = await query.get();

    final filteredData = <T>[];
    for (final doc in querySnapshot.docs) {
      if (doc.data() != null) {
        final data = doc.data()! as Map<String, dynamic>;
        data['id'] = doc.id;
        final e = _fromMap(data);
        filteredData.add(e);
      }
    }
    return filteredData;
  }

  Map<String, dynamic> _toMap(T obj) {
    return obj.toMap();
  }
}
