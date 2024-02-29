///
abstract class SynrgClass {
  ///
  SynrgClass(this.id);

  /// Object identification
  final String? id;

  /// Mapper function
  // SynrgClass fromMap(Map<String, dynamic> map);

  /// Mapper function
  Map<String, dynamic> toMap();

  /// save function
  Future<void> save();

  /// Force override from.Map constructor
  factory SynrgClass.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
