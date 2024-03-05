///
abstract class SynrgClass {
  ///
  SynrgClass(this.id);

  /// Force override from.Map constructor
  factory SynrgClass.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  /// Object identification
  final String? id;

  /// Mapper function, used by indexer to parse data
  Map<String, dynamic> toMap();

  /// save function, persists the changes in Firestore
  Future<void> save();

  /// copy with
  SynrgClass copyWith({String? id});
}
