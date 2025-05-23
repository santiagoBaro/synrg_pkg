/// Stubbed SynrgStorage for unsupported platforms (Web/WASM)
class SynrgStorage {
  SynrgStorage._privateConstructor();
  static final SynrgStorage _instance = SynrgStorage._privateConstructor();

  /// Provides a global access point to the SynrgStorage instance
  static SynrgStorage get instance => _instance;

  Never _unsupported() =>
      throw UnsupportedError('SynrgStorage is not supported on this platform.');

  /// Uploads a file to Firebase Cloud Storage
  Future<String?> uploadFile(String path, dynamic file) async => _unsupported();

  /// Downloads a file from Firebase Cloud Storage
  Future<dynamic> downloadFile(String path, String localPath) async =>
      _unsupported();

  /// Deletes a file from Firebase Cloud Storage
  Future<void> deleteFile(String path) async => _unsupported();
}
