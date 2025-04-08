// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:synrg/src/query_filter.dart';
import 'package:synrg/synrg.dart';

//?
final payments = SynrgFunction<Project>('payments', Project.fromMap);
final response = payments.call({'id': 'random_id'});

//? Indexed Class Implementation
final projectIndex = SynrgIndexer<Project>('projects', Project.fromMap);
final project = projectIndex.get('project-id');
final projectList = projectIndex.batchGet([
  'project-id-1',
  'project-id-2',
  'project-id-3',
]);
final projectQuery =
    projectIndex.query([QueryFilter('type', isEqualTo: 'Ongoing')]);

class Project extends SynrgClass {
  final String name;
  final String type;
  Project({
    required this.name,
    required this.type,
    super.id,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
    };
  }

  @override
  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['name'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
    );
  }

  @override
  Future<void> save() async {
    await projectIndex.save(this);
  }

  Future<void> delete() async {
    await projectIndex.delete(id!);
  }

  Project copyWith({String? id, String? name, String? type}) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  List<Object?> get props => [id, name, type];
}

//? Synrg Bloc Provider implementation
// class DummyWidget extends StatelessWidget {
//   const DummyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SynrgBlocProvider<SynrgSessionBloc>(
//       bloc: SynrgSessionBloc(),
//       builder: (context, state) {
//         // Your widget content based on state
//         return Container();
//       },
//     );
//   }
// }

//? Stateful validation implementation
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: validatePlainText,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

//? Stateless form validation implementation
class MyStatelessForm extends StatelessWidget {
  MyStatelessForm({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: validatePlainText,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

//? Synrg Crashlytics
void dummy2() {
  // Log an error
  try {
    // Your code that might throw an exception
  } catch (e, stackTrace) {
    SynrgCrashlytics.instance.logError(
      e as Error,
      stackTrace,
      reason: 'Uncaught exception',
    );
  }

  // Set a custom key-value pair
  SynrgCrashlytics.instance.setCustomKey(key: 'page', value: 'userProfile');

  // Set the user identifier
  SynrgCrashlytics.instance.setUserIdentifier('12345');

  // Log a custom message
  SynrgCrashlytics.instance.logMessage('User profile loaded');

  // Enable or disable crash reports collection
  SynrgCrashlytics.instance.setCrashlyticsCollectionEnabled(enabled: true);
}

//? Synrg Performance
Future<void> dummy3() async {
  // Start a new trace
  final trace = await SynrgPerformance.instance.startTrace('myCustomTrace');

  // Do something...

  // Stop the trace
  await SynrgPerformance.instance.stopTrace(trace);

  // Increment a metric
  SynrgPerformance.instance.incrementMetric(trace, 'metricName', 1);

  // Set a custom attribute for a trace
  SynrgPerformance.instance.setAttribute(trace, 'attributeName', 'value');

  // Manually track an HTTP request
  final metric = await SynrgPerformance.instance.startHttpMetric(
    'https://example.com',
    HttpMethod.Get,
  );

  // Do something with the metric...

  // Stop tracking the HTTP request
  await SynrgPerformance.instance.stopHttpMetric(metric);
}

//? Synrg Storage
Future<void> dummy4() async {
  final fileToUpload = File('path/to/local/file.jpg');

  // Upload a file
  final downloadUrl = await SynrgStorage.instance.uploadFile(
    'uploads/file.jpg',
    fileToUpload,
  );
  if (downloadUrl != null) {
    if (kDebugMode) {
      print('File uploaded: $downloadUrl');
    }
  }

  // Download a file
  final downloadedFile = await SynrgStorage.instance.downloadFile(
    'uploads/file.jpg',
    'path/to/save/file.jpg',
  );
  if (downloadedFile != null) {
    if (kDebugMode) {
      print('File downloaded to: ${downloadedFile.path}');
    }
  }

  // Delete a file
  await SynrgStorage.instance.deleteFile('uploads/file.jpg');
}

//? Synrg Remote Config
Future<void> dummy5() async {
  // Initialize Remote Config with default values
  await SynrgRemoteConfig.instance.initialize(
    defaultValues: {
      'welcome_message': 'Welcome to our app!',
      'feature_enabled': false,
    },
  );

  // Fetch and activate the latest Remote Config values
  await SynrgRemoteConfig.instance.fetchAndActivate();

  // Retrieve a string value
  final welcomeMessage =
      SynrgRemoteConfig.instance.getString('welcome_message');
  if (kDebugMode) {
    print(welcomeMessage);
  }

  // Retrieve a boolean value
  final featureEnabled = SynrgRemoteConfig.instance.getBool('feature_enabled');
  if (kDebugMode) {
    print(featureEnabled ? 'Feature is enabled' : 'Feature is disabled');
  }
}

//? Synrg Analytics
Future<void> dummy6() async {
  // Log a custom event
  await SynrgAnalytics.instance.logEvent('test_event', {'parameter': 'value'});

  // Set a user property
  await SynrgAnalytics.instance
      .setUserProperty(name: 'user_type', value: 'premium');

  // Set the user ID
  await SynrgAnalytics.instance.setUserId('user123');

  // Log a screen view
  await SynrgAnalytics.instance.logScreenView('HomeScreen');
}

//? Synrg Realtime Database
Future<void> dummy7() async {
  // Write data
  await SynrgRealtimeDatabase.instance
      .writeData('users/user1', {'name': 'John', 'age': 30});

  // Read data
  final snapshot = await SynrgRealtimeDatabase.instance.readData('users/user1');
  if (snapshot != null) {
    if (kDebugMode) {
      print(snapshot.value);
    }
  }

  // Listen to data changes
  SynrgRealtimeDatabase.instance.listenToData('users/user1', (snapshot) {
    if (kDebugMode) {
      print('Data changed: ${snapshot.value}');
    }
  });

  // Update data
  await SynrgRealtimeDatabase.instance.updateData('users/user1', {'age': 31});

  // Delete data
  await SynrgRealtimeDatabase.instance.deleteData('users/user1');
}

// import 'package:app/models/models.dart';
// import 'package:synrg/synrg.dart';

// class RelationTest extends SynrgClass {
//   RelationTest({
//     required this.status,
//     required this.name,
//     required this.profile,
//     required this.projects,
//     required this.friends,
//     super.id,
//     List<String> projectIds = const [],
//     String profileId = '',
//   })  : _projectIds = projectIds,
//         _profileId = profileId;

//   // ModelType is an typeEnum
//   ModelType status;
//   String name;
//   // FK<Profile> profile;
//   String _profileId;
//   Profile profile;
//   // FKL<Project> projects;
//   final List<String> _projectIds;
//   List<Project> projects;
//   // FQL<Profile> friends;
//   List<Profile> friends;
//   DocumentSnapshot? _friendsLast;

//   static RelationTest fromMap(Map<String, dynamic> map) {
//     return RelationTest(
//       status: ModelType.read(map['status'] as String? ?? ''),
//       name: map['name'] as String? ?? '',
//       profile: Profile.fromMap(map['profile']! as Map<String, dynamic>),
//       profileId: map['profileId'] as String? ?? '',
//       projects: map['projects'] == null
//           ? []
//           : (map['projects']! as List<dynamic>)
//               .map((e) => Project.fromMap(e as Map<String, dynamic>))
//               .toList(),
//       projectIds: (map['projectIds'] as List<String>?) ?? [],
//       friends: map.containsKey('friends')
//           ? (map['friends']! as List<dynamic>)
//               .map((e) => Profile.fromMap(e as Map<String, dynamic>))
//               .toList()
//           : [],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     final projectAttrs = ['id', 'name'];
//     final profileAttrs = ['id', 'name'];
//     final friendAttrs = ['id', 'name'];
//     return {
//       'status': status.name,
//       'name': name,
//       'profileId': _profileId,
//       'profile': Map.fromEntries(profile
//           .toMap()
//           .entries
//           .where((entry) => profileAttrs.contains(entry.key))),
//       'projects': projects.isEmpty
//           ? []
//           : projects
//               .sublist(0, projects.length < 10 ? projects.length : 10)
//               .map(
//                 (e) => e
//                     .toMap()
//                     .entries
//                     .where((entry) => projectAttrs.contains(entry.key)),
//               )
//               .toList(),
//       'projectIds': _projectIds,
//       'friends': friends.isEmpty
//           ? []
//           : friends
//               .sublist(0, friends.length < 10 ? friends.length : 10)
//               .map(
//                 (e) => e
//                     .toMap()
//                     .entries
//                     .where((entry) => friendAttrs.contains(entry.key)),
//               )
//               .toList(),
//     };
//   }

//   @override
//   Future<void> save() async {
//     relationTestIndex.save(this);
//     await super.save();
//   }

//   // related to FK<Profile> profile;
//   Future<Profile> getProfile() async {
//     return profile = await profileIndex.get(_profileId) ?? profile;
//   }

//   // related to FKL<Project> projects;
//   Future<List<Project>?> getProjects() async {
//     if (_projectIds.isEmpty) return projects = [];

//     final end = _projectIds.length < 10 ? _projectIds.length : 10;
//     projects = await projectIndex.batchGet(
//           _projectIds.sublist(0, end),
//         ) ??
//         [];

//     await save();
//     return projects;
//   }

//   // related to FKL<Project> projects;
//   Future<List<Project>?> nextProjects() async {
//     final remaining = _projectIds.length - projects.length;
//     if (remaining > 0) {
//       final start = projects.length;
//       final end =
//          (_projectIds.length < start + 10) ? _projectIds.length : start + 10;

//       final newProjects = await projectIndex.batchGet(
//         _projectIds.sublist(start, end),
//       );

//       if (newProjects == null) return null;
//       projects.addAll(newProjects);
//       return newProjects;
//     }
//     return null;
//   }

//   // related to FQL<Profile> friends;
//   Future<List<Profile>?> getFriends() async {
//     final friendsData = await profileIndex.query([
//       QueryFilter('id', isNotEqualTo: profile.id),
//     ]);
//     if (friendsData == null) return null;
//     friends = friendsData.data;
//     _friendsLast = friendsData.lastDocument;
//     await save();
//     return friendsData.data;
//   }

//   // related to FQL<Profile> friends;
//   Future<List<Profile>?> nextFriends() async {
//     final newFriendsData = await profileIndex.query(
//       [
//         QueryFilter('id', isNotEqualTo: profile.id),
//       ],
//       startAfter: _friendsLast,
//     );
//     if (newFriendsData == null) return null;
//     friends.addAll(newFriendsData.data);
//     _friendsLast = newFriendsData.lastDocument;
//     return newFriendsData.data;
//   }
// }
