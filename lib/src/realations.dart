import 'dart:nativewrappers/_internal/vm/lib/mirrors_patch.dart';

import 'package:synrg/src/example.dart';
import 'package:synrg/synrg.dart';
import 'package:uuid/uuid.dart';

class Profile extends SynrgClass {
  late final String name;
  var project = FK<Project>(
    fromMap: Project.fromMap,
    indexer: projectIndex,
    attrs: ['id', 'name', 'type'],
  );

  static Profile fromMap(Map<String, Object> map) {
    return Profile()
      ..name = map['name'] as String
      ..project = FK<Project>(
        fromMap: Project.fromMap,
        indexer: projectIndex,
        attrs: ['id', 'name', 'type'],
        data: map['project'] as Map<String, dynamic>,
      );
  }
}

final Profile profile = Profile.fromMap({
  'name': 'John Doe',
  'project': {
    'id': 'project-id',
    'name': 'Project Name',
    'type': 'Ongoing',
  },
});

var projectId = profile.project.id;
var projectName = profile.project['name'];
var projectNames = profile.project.instance.name;

var foreignKey = FK<Project>(
  fromMap: Project.fromMap,
  indexer: projectIndex,
  attrs: ['id', 'name', 'type'],
);
var ne = foreignKey.instance.name;

var foreignKeyList = FKL<Project>(
  fromMapItem: Project.fromMap,
  indexer: projectIndex,
  attrs: ['id', 'name', 'type'],
);

var nel = foreignKeyList.instances.length;
var nels = foreignKeyList.instances[0].name;

final fkQuery = FKQ<Project>(
  fromMap: Project.fromMap,
  indexer: projectIndex,
  queries: [
    Query('type', isEqualTo: 'software'),
  ],
  page: 5,
  cachedAttributes: ['id', 'name'],
);

final results = fkQuery.fetch().then((value) => value![0].instance.name);

/// Foreign key class
/// This is used to represent a foreign key in a database
// class FK<T extends SynrgClass> {
//   FK({
//     required this.fromMap,
//     required this.indexer,
//     this.data = const {},
//     this.attrs = const ['id'],
//   }) : instance = fromMap(data);
//   final T Function(Map<String, dynamic>) fromMap;
//   final SynrgIndexer indexer;
//   final Map<String, dynamic> data;
//   final List<String> attrs;
//   final T instance;
//   String? get id => data['id'] as String?;
//   /// Forward access to instance attributes
//   @override
//   dynamic noSuchMethod(Invocation invocation) {
//     final memberName = MirrorSystem.getName(invocation.memberName);
//     if (data.containsKey(memberName)) {
//       return data[memberName];
//     }
//     return super.noSuchMethod(invocation);
//   }
//   /// Converts the instance to a map but includes only the attributes in `attrs`
//   Map<String, dynamic> toMap() {
//     final fullMap = instance.toMap();
//     return {
//       for (final key in attrs)
//         if (fullMap.containsKey(key)) key: fullMap[key]
//     };
//   }
// }

/// Foreign key class
/// This is used to represent a foreign key in a database
class FK<T extends SynrgClass> {
  FK({
    required this.fromMap,
    required this.indexer,
    this.data = const {},
    this.attrs = const ['id'],
  }) : instance = fromMap(data);

  final T Function(Map<String, dynamic>) fromMap;
  final SynrgIndexer indexer;
  final Map<String, dynamic> data;
  final List<String> attrs;
  final T instance;

  /// Get the ID from data
  String? get id => data['id'] as String?;

  /// Enable dynamic access using `fk['attributeName']`
  dynamic operator [](String key) {
    final fullMap = instance.toMap();
    if (fullMap.containsKey(key)) {
      return fullMap[key];
    }
    throw ArgumentError('Attribute $key does not exist in ${T.runtimeType}');
  }

  /// Converts the instance to a map but only includes attributes in `attrs`
  Map<String, dynamic> toMap() {
    final fullMap = instance.toMap();
    return {
      for (final key in attrs)
        if (fullMap.containsKey(key)) key: fullMap[key]
    };
  }
}

/// Foreign key list class
/// This is used to represent a list of foreign keys in a database
class FKL<T extends SynrgClass> {
  FKL({
    required this.fromMapItem,
    required this.indexer,
    this.attrs = const ['id'],
  });

  final T Function(Map<String, dynamic>) fromMapItem;
  final List<String> attrs;
  final SynrgIndexer indexer;

  List<T> fromMap(List<Map<String, dynamic>> data) {
    return data.map(fromMapItem).toList();
  }

  /// Internal list of foreign keys
  final List<T> _instance = [];

  /// Converts the FKL list to a list of maps with only the attributes in attrs
  List<Map<String, dynamic>> toMap() {
    return _instance.map((fk) {
      final fullMap = fk.toMap();
      return {
        for (final key in attrs)
          if (fullMap.containsKey(key)) key: fullMap[key],
      };
    }).toList();
  }

  /// Returns a list of stored foreign key IDs
  List<String?> get ids => _instance.map((fk) => fk.id).toList();

  /// Get all FK instances
  List<T> get instances => List.unmodifiable(_instance);
}

/// Foreign key query class
/// This is used to represent a query with a foreign key in a database
class FKQ<T extends SynrgClass> {
  FKQ({
    required this.fromMap,
    required this.indexer,
    required this.queries,
    this.page = 10,
    this.cachedAttributes = const ['id'],
  });

  final T Function(Map<String, dynamic>) fromMap;
  final List<String> cachedAttributes;
  final SynrgIndexer<T> indexer;
  final List<Query> queries;
  final int page;

  /// Fetches the query results using `multiQuery`
  Future<List<FK<T>>?> fetch() async {
    final result = await indexer.multiQuery(queries, limit: page);

    if (result == null) return null;

    return result.map((data) {
      return FK<T>(
        fromMap: fromMap,
        indexer: indexer,
        data: _filterCachedAttributes(data.toMap()),
        attrs: cachedAttributes,
      );
    }).toList();
  }

  /// Filters the attributes to only include the ones in `cachedAttributes`
  Map<String, dynamic> _filterCachedAttributes(Map<String, dynamic> fullData) {
    return {
      for (final key in cachedAttributes)
        if (fullData.containsKey(key)) key: fullData[key],
    };
  }
}
