import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synrg/synrg.dart';

/// Firestore Wrapper, get and set given a "collectionName"
class SynrgIndexer<T extends SynrgClass> {
  /// Initializes the indexer for the given collection
  SynrgIndexer(String collectionName, this._fromMap) {
    _collectionName = collectionName;
    _collection = FirebaseFirestore.instance.collection(collectionName);
  }

  ///
  late String _collectionName;
  late CollectionReference _collection;
  final T Function(Map<String, dynamic>) _fromMap;
  final _performance = SynrgPerformance.instance;

  /// Get data by id
  Future<T?> get(String id) async {
    final trace =
        await _performance.startTrace('Indexer get ( $_collectionName )');
    try {
      final documentSnapshot = await _collection.doc(id).get();
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data()! as Map<String, dynamic>;
        data['id'] = id;
        return _fromMap(data);
      }
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Exception,
        stackTrace,
        reason: 'Indexer Get ($_collectionName) Exception',
      );
    }
    return null;
  }

  /// Persist the changes in Fire Store
  Future<T?> save(T obj) async {
    final trace =
        await _performance.startTrace('Indexer save ( $_collectionName )');
    try {
      final data = _toMap(obj)!;
      if (!data.containsKey('id') || data['id'].toString().isEmpty) {
        final response = await _collection.add(data);
        data['id'] = response.id;
      } else {
        await _collection.doc(data['id'].toString()).set(data);
      }
      return obj;
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Exception,
        stackTrace,
        reason: 'Indexer Save ($_collectionName) Exception',
      );
      return null;
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
    }
  }

  /// Batch get a list of ids
  Future<List<T>?> batchGet(List<String> ids) async {
    final trace =
        await _performance.startTrace('Indexer batchGet ( $_collectionName )');
    try {
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
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Exception,
        stackTrace,
        reason: 'Indexer Batch Get ($_collectionName) Exception',
      );
      return null;
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
    }
  }

  /// Paginated query method
  Future<List<T>?> query({
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
    final trace =
        await _performance.startTrace('Indexer query ( $_collectionName )');
    try {
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
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Exception,
        stackTrace,
        reason: 'Indexer Query ($_collectionName) Exception',
      );
      return null;
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
    }
  }

  Map<String, dynamic>? _toMap(T obj) {
    try {
      return obj.toMap();
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Exception,
        stackTrace,
        reason: 'Indexer _toMap ($_collectionName) Exception',
      );
      return null;
    }
  }
}
