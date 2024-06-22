import 'package:equatable/equatable.dart';

///
abstract class SynrgClass extends Equatable {
  ///
  const SynrgClass({this.id, this.parent});

  /// Force override from.Map constructor
  factory SynrgClass.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError('Missing fromMap implementation $map');
  }

  /// Object identification
  final String? id;

  /// Parent class, used for cascade save
  final SynrgClass? parent;

  /// Mapper function, used by indexer to parse data
  Map<String, dynamic> toMap() {
    throw UnimplementedError('Missing toMap implementation');
  }

  /// save function, persists the changes in FireStore
  Future<void> save() {
    throw UnimplementedError('Missing save implementation');
  }

  /// copy with
  SynrgClass copyWith({String? id}) {
    throw UnimplementedError('Missing copyWith implementation');
  }
}
