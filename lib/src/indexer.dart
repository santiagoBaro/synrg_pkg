// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synrg/synrg.dart';

/// Holds the data list and the snapshot of the last document for pagination.
class PaginatedResult<T> {
  PaginatedResult({required this.data, this.lastDocument});
  final List<T> data;
  final DocumentSnapshot? lastDocument;
}

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
        e as Error,
        stackTrace,
        reason: 'Indexer Get ($_collectionName) Exception',
      );
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
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
        e as Error,
        stackTrace,
        reason: 'Indexer Save ($_collectionName) Exception',
      );
      return null;
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
    }
  }

  /// Delete the document by id
  Future<void> delete(String id) async {
    final trace =
        await _performance.startTrace('Indexer delete ( $_collectionName )');
    try {
      await _collection.doc(id).delete();
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Error,
        stackTrace,
        reason: 'Indexer Delete ($_collectionName) Exception',
      );
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
        e as Error,
        stackTrace,
        reason: 'Indexer Batch Get ($_collectionName) Exception',
      );
      return null;
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
    }
  }

  /// Query method that has multiple filters
  Future<PaginatedResult<T>?> query(
    List<QueryFilter> queries, {
    int limit = 10,
    String? orderBy,
    DocumentSnapshot? startAfter,
  }) async {
    final trace = await _performance
        .startTrace('Indexer multiQuery ( $_collectionName )');
    try {
      var queryObj = _collection.limit(limit);
      for (final q in queries) {
        queryObj = queryObj.where(
          q.field,
          isEqualTo: q.isEqualTo,
          isNotEqualTo: q.isNotEqualTo,
          isLessThan: q.isLessThan,
          isLessThanOrEqualTo: q.isLessThanOrEqualTo,
          isGreaterThan: q.isGreaterThan,
          isGreaterThanOrEqualTo: q.isGreaterThanOrEqualTo,
          arrayContains: q.arrayContains,
          arrayContainsAny: q.arrayContainsAny,
          whereIn: q.whereIn,
          whereNotIn: q.whereNotIn,
          isNull: q.isNull,
        );
      }
      if (orderBy != null) {
        queryObj.orderBy(orderBy);
      }
      if (startAfter != null) {
        queryObj = queryObj.startAfterDocument(startAfter);
      }
      final querySnapshot = await queryObj.get();

      final filteredData = <T>[];
      for (final doc in querySnapshot.docs) {
        if (doc.data() != null) {
          final data = doc.data()! as Map<String, dynamic>;
          data['id'] = doc.id;
          final e = _fromMap(data);
          filteredData.add(e);
        }
      }
      return PaginatedResult(
        data: filteredData,
        lastDocument:
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
      );
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Error,
        stackTrace,
        reason: 'Indexer Multi Query ($_collectionName) Exception',
      );
      return null;
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
    }
  }

  /// Paginated search method
  Future<PaginatedResult<T>?> search(
    String field, {
    required String filter,
    String? orderBy,
    bool descending = false,
    int limit = 10,
    DocumentSnapshot? startAfter,
    String? createdBy,
  }) async {
    try {
      var query = _collection
          .where(
            field,
            isGreaterThanOrEqualTo: filter,
            isLessThan: filter.substring(0, filter.length - 1) +
                String.fromCharCode(filter.codeUnitAt(filter.length - 1) + 1),
          )
          .limit(limit);

      if (createdBy != null) {
        query = query.where('createdBy', isEqualTo: createdBy);
      }

      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }

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
      return PaginatedResult(
        data: filteredData,
        lastDocument:
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
      );
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Error,
        stackTrace,
        reason: 'Indexer Query ($_collectionName) Exception',
      );
      return null;
    }
  }

  /// Paginated fuzzy search method for array fields
  /// the field must be stored as an array of strings
  Future<PaginatedResult<T>?> fuzzySearch(
    String field, {
    required String filter,
    String? orderBy,
    bool descending = false,
    int limit = 10,
    DocumentSnapshot? startAfter,
    String? createdBy,
  }) async {
    try {
      var query = _collection.where(field, arrayContains: filter).limit(limit);

      if (createdBy != null) {
        query = query.where('createdBy', isEqualTo: createdBy);
      }

      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }

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
      return PaginatedResult(
        data: filteredData,
        lastDocument:
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
      );
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Error,
        stackTrace,
        reason: 'Indexer Query ($_collectionName) Exception',
      );
      return null;
    }
  }

  /// Get a paginated list of all documents
  Future<PaginatedResult<T>?> list({
    DocumentSnapshot? startAfter,
    int limit = 10,
    String? createdBy,
    String? orderBy,
    bool descending = false,
  }) async {
    var query = _collection.limit(limit);

    if (createdBy != null) {
      query = query.where('createdBy', isEqualTo: createdBy);
    }

    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final querySnapshot = await query.get();

    final data = querySnapshot.docs.map((doc) {
      final data = doc.data()! as Map<String, dynamic>;
      data['id'] = doc.id;
      return _fromMap(data);
    }).toList();
    return PaginatedResult<T>(
      data: data,
      lastDocument:
          querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
    );
  }

  Map<String, dynamic>? _toMap(T obj) {
    try {
      return obj.toMap();
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Error,
        stackTrace,
        reason: 'Indexer _toMap ($_collectionName) Exception',
      );
      return null;
    }
  }
}
