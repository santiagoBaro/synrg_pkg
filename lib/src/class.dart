import 'package:uuid/uuid.dart';

///
abstract class SynrgClass {
  ///
  SynrgClass({this.id, this.parent});

  /// Force override from.Map constructor
  factory SynrgClass.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError('Missing fromMap implementation $map');
  }

  /// Object identification
  String? id;

  /// Parent class, used for cascade save
  SynrgClass? parent;

  /// Mapper function, used by indexer to parse data
  Map<String, dynamic> toMap() {
    throw UnimplementedError('Missing toMap implementation');
  }

  /// save function, persists the changes in FireStore
  Future<void> save() async {
    id ??= const Uuid().v4();
    if (parent != null) {
      await parent!.save();
    }
  }
}
