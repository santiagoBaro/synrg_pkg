import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synrg/src/example.dart';
import 'package:synrg/synrg.dart';

class Profile extends SynrgClass {
  late final String name;
  var project = FK<Project>(
    fromMap: Project.fromMap,
    indexer: projectIndex,
    attrs: ['id', 'name', 'type'],
  );

  static Profile fromMap(Map<String, dynamic> map) {
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

final profileIndex = SynrgIndexer<Profile>('profiles', Profile.fromMap);

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
  attrs: ['id', 'name'],
  queries: [
    QueryFilter('type', isEqualTo: 'software'),
  ],
);

final results = fkQuery.fetch().then((value) => value![0].instance.name);
final results2 = fkQuery.instances.length;

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
    this.attrs = const ['id'],
  });

  final T Function(Map<String, dynamic>) fromMap;
  final List<String> attrs;
  final SynrgIndexer<T> indexer;
  final List<QueryFilter> queries;
  final int page;

  /// Internal list of foreign key instances
  final List<FK<T>> _instances = [];

  /// Fetches the query results using `multiQuery`
  Future<List<FK<T>>?> fetch() async {
    final result = await indexer.query(queries, limit: page);

    if (result == null) return null;

    _instances
      ..clear()
      ..addAll(
        result.data.map((data) {
          return FK<T>(
            fromMap: fromMap,
            indexer: indexer,
            data: _filterCachedAttributes(data.toMap()),
            attrs: attrs,
          );
        }),
      );

    return List.unmodifiable(_instances); // Return a copy of the instances
  }

  /// Filters the attributes to only include the ones in `cachedAttributes`
  Map<String, dynamic> _filterCachedAttributes(Map<String, dynamic> fullData) {
    return {
      for (final key in attrs)
        if (fullData.containsKey(key)) key: fullData[key],
    };
  }

  /// Get all FK instances
  List<FK<T>> get instances => List.unmodifiable(_instances);
}

enum ModelType {
  typeModel,
  typeIndex,
  typeEnum,
  typeConst,
  typeSecret;

  static ModelType read(String type) {
    switch (type.toLowerCase()) {
      case 'typemodel':
        return ModelType.typeModel;
      case 'typeindexablemodel':
        return ModelType.typeModel;
      case 'typeindex':
        return ModelType.typeIndex;
      case 'typeenum':
        return ModelType.typeEnum;
      case 'typeconst':
        return ModelType.typeConst;
      case 'typesecret':
        return ModelType.typeSecret;
      default:
        throw ArgumentError('Invalid model type: $type');
    }
  }
}

///
extension ModelTypeExtension on ModelType {
  ///
  String get displayName {
    return name.replaceFirst('type', '');
  }
}

///
class RelationTest extends SynrgClass {
  ///
  RelationTest({
    required this.status,
    required this.name,
    required this.profile,
    required this.projects,
    required this.friends,
    List<String> projectIds = const [],
  }) : _projectIds = projectIds;

  ///
  static RelationTest fromMap(Map<String, Object> map) {
    return RelationTest(
      status: ModelType.read(map['status'] as String? ?? ''),
      name: map['name'] as String? ?? '',
      profile: Profile.fromMap(map['profile']! as Map<String, dynamic>),
      projects: map['projects'] == null
          ? []
          : (map['projects']! as List<Object>)
              .map((e) => Project.fromMap(e as Map<String, Object>))
              .toList(),
      projectIds: (map['projectIds'] as List<String>?) ?? [],
      friends: map.containsKey('friends')
          ? (map['friends']! as List<Object>)
              .map((e) => Profile.fromMap(e as Map<String, Object>))
              .toList()
          : [],
    );
  }

  ///
  ModelType status;

  ///
  String name;

  /// FK<Profile> profile;
  Profile profile;

  /// FKL<Project> projects;
  List<Project> projects;

  /// FQL<Profile> friends;
  List<Profile> friends;

  ///
  DocumentSnapshot? friendsStartAfter;
  final List<String> _projectIds;

  @override
  Map<String, Object> toMap() {
    final projectAttrs = ['id', 'name'];
    final profileAttrs = ['id', 'name'];
    final friendAttrs = ['id', 'name'];
    return {
      'status': status.name,
      'name': name,
      'profile': Map.fromEntries(profile
          .toMap()
          .entries
          .where((entry) => profileAttrs.contains(entry.key))),
      'projects': projects
          .sublist(0, 10)
          .map(
            (e) => e
                .toMap()
                .entries
                .where((entry) => projectAttrs.contains(entry.key)),
          )
          .toList(),
      'projectIds': _projectIds,
      'friends': friends
          .sublist(0, 10)
          .map(
            (e) => e
                .toMap()
                .entries
                .where((entry) => friendAttrs.contains(entry.key)),
          )
          .toList(),
    };
  }

  /// related to FK<Profile> profile;
  Future<Profile> getProfile() async {
    return profile = await profileIndex.get(profile.id!) ?? profile;
  }

  /// related to FKL<Project> projects;
  Future<List<Project>?> getProjects() async {
    return projects = await projectIndex.batchGet(
          _projectIds.sublist(0, 10),
        ) ??
        [];
  }

  /// related to FKL<Project> projects;
  Future<List<Project>?> nextProjects() async {
    if (_projectIds.length > projects.length) {
      final newProjects = await projectIndex.batchGet(
        _projectIds.sublist(
          projects.length,
          projects.length + 10,
        ),
      );
      if (newProjects == null) return null;
      projects.addAll(newProjects);
      return newProjects;
    }
    return null;
  }

  /// related to FQL<Profile> friends;
  Future<List<Profile>?> getFriends() async {
    final friendsData = await profileIndex.query([
      QueryFilter('id', isNotEqualTo: profile.id),
    ]);
    if (friendsData == null) return null;
    friends = friendsData.data;
    friendsStartAfter = friendsData.lastDocument;
    return friendsData.data;
  }

  /// related to FQL<Profile> friends;
  Future<List<Profile>?> nextFriends() async {
    final friendsData = await profileIndex.query(
      [
        QueryFilter('id', isNotEqualTo: profile.id),
      ],
      startAfter: friendsStartAfter,
    );

    if (friendsData == null) return null;
    friends = friendsData.data;
    friendsStartAfter = friendsData.lastDocument;
    friends.addAll(friendsData.data);
    return friendsData.data;
  }
}
