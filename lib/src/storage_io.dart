import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:synrg/synrg.dart';

/// A Firebase Cloud Storage wrapper
class SynrgStorage {
  /// Private constructor
  SynrgStorage._privateConstructor();

  /// The single instance of SynrgStorage
  static final SynrgStorage _instance = SynrgStorage._privateConstructor();

  /// Provides a global access point to the SynrgStorage instance
  static SynrgStorage get instance => _instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final _performance = SynrgPerformance.instance;

  /// Uploads a file to Firebase Cloud Storage
  Future<String?> uploadFile(String path, File file) async {
    final trace = await _performance.startTrace('uploadFile path ( $path )');
    try {
      // Create a reference to the location you want to
      // upload to in Firebase Storage
      final ref = _storage.ref(path);

      // Upload the file
      final uploadTask = ref.putFile(file);

      // Wait for the upload to complete
      await uploadTask;

      // Get and return the download URL
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Error,
        stackTrace,
        reason: 'Synrg Storage Upload File Exception',
      );
      return null;
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
    }
  }

  /// Downloads a file from Firebase Cloud Storage
  Future<File?> downloadFile(String path, String localPath) async {
    final trace = await _performance.startTrace('downloadFile path ( $path )');
    try {
      // Create a reference to the file we want to download
      final ref = _storage.ref(path);

      // Download the file to a local path
      final file = File(localPath);
      await ref.writeToFile(file);

      return file;
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Error,
        stackTrace,
        reason: 'Synrg Storage Download File Exception',
      );
      return null;
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
    }
  }

  /// Deletes a file from Firebase Cloud Storage
  Future<void> deleteFile(String path) async {
    final trace = await _performance.startTrace('deleteFile path ( $path )');
    try {
      // Create a reference to the file to delete
      final ref = _storage.ref(path);

      // Delete the file
      await ref.delete();
    } catch (e, stackTrace) {
      SynrgCrashlytics.instance.logError(
        e as Error,
        stackTrace,
        reason: 'Synrg Storage Delete File Exception',
      );
    } finally {
      await SynrgPerformance.instance.stopTrace(trace);
    }
  }
}
