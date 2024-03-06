import 'package:firebase_database/firebase_database.dart';
import 'package:synrg/synrg.dart';

/// A Firebase Realtime Database wrapper
class SynrgRealtimeDatabase {
  /// Private constructor
  SynrgRealtimeDatabase._privateConstructor();

  /// The single instance of SynrgDatabase
  static final SynrgRealtimeDatabase _instance =
      SynrgRealtimeDatabase._privateConstructor();

  /// Provides a global access point to the SynrgDatabase instance
  static SynrgRealtimeDatabase get instance => _instance;
  final _performance = SynrgPerformance.instance;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  ///
  Future<void> writeData(String path, Map<String, dynamic> data) async {
    final trace = await _performance.startTrace('writeData path ( $path )');
    try {
      final ref = _database.ref(path);
      await ref.set(data);
      SynrgPerformance.instance.incrementMetric(trace, 'success', 1);
    } catch (e, stackTrace) {
      SynrgPerformance.instance.incrementMetric(trace, 'failure', 1);
      SynrgCrashlytics.instance.logError(
        e as Exception,
        stackTrace,
        reason: 'RealTime Database Write exception',
      );
    } finally {
      await _performance.stopTrace(trace);
    }
  }

  ///
  Future<DataSnapshot?> readData(String path) async {
    final trace = await _performance.startTrace('addData path ( $path )');
    try {
      final ref = _database.ref(path);
      final snapshot = await ref.get();
      SynrgPerformance.instance.incrementMetric(trace, 'success', 1);
      if (snapshot.exists) {
        return snapshot;
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      SynrgPerformance.instance.incrementMetric(trace, 'failure', 1);
      SynrgCrashlytics.instance.logError(
        e as Exception,
        stackTrace,
        reason: 'RealTime Database Read exception',
      );
      return null;
    } finally {
      await _performance.stopTrace(trace);
    }
  }

  /// Sets up a listener at the specified path for real-time updates
  void listenToData(String path, void Function(DataSnapshot snapshot) onData) {
    final ref = _database.ref(path);
    ref.onValue.listen(
      (event) {
        onData(event.snapshot);
      },
      onError: (Object e, StackTrace s) {
        // Specify types for e and s
        SynrgCrashlytics.instance.logError(
          e as Exception,
          s,
          reason: 'RealTime Database Update exception',
        );
      },
    );
  }

  /// Updates data at the specified path in the database
  Future<void> updateData(String path, Map<String, dynamic> data) async {
    final trace = await _performance.startTrace('updateData path ( $path )');
    try {
      final ref = _database.ref(path);
      await ref.update(data);
      SynrgPerformance.instance.incrementMetric(trace, 'success', 1);
    } catch (e, stackTrace) {
      SynrgPerformance.instance.incrementMetric(trace, 'failure', 1);
      SynrgCrashlytics.instance.logError(
        e as Exception,
        stackTrace,
        reason: 'RealTime Database Update exception',
      );
    } finally {
      await _performance.stopTrace(trace);
    }
  }

  /// Deletes data at the specified path in the database
  Future<void> deleteData(String path) async {
    final trace = await _performance.startTrace('deleteData path ( $path )');
    try {
      final ref = _database.ref(path);
      await ref.remove();
      SynrgPerformance.instance.incrementMetric(trace, 'success', 1);
    } catch (e, stackTrace) {
      SynrgPerformance.instance.incrementMetric(trace, 'failure', 1);
      SynrgCrashlytics.instance.logError(
        e as Exception,
        stackTrace,
        reason: 'RealTime Database Delete exception',
      );
    } finally {
      await _performance.stopTrace(trace);
    }
  }
}
