// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:synrg/synrg.dart';

//?
final payments = SynrgFunction<Project>('payments', Project.fromMap);
final response = payments.call({'id': 'random_id'});

//? Indexed Class Implementation
final projectIndex = SynrgIndexer<Project>('projects', Project.fromMap);

class Project extends SynrgClass {
  String name;
  String type;
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

  @override
  Project copyWith({String? id, String? name, String? type}) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [id, name, type];
}

//? Synrg Bloc Provider implementation
class DummyWidget extends StatelessWidget {
  const DummyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SynrgBlocProvider<SynrgSessionBloc>(
      bloc: SynrgSessionBloc(),
      builder: (context, state) {
        // Your widget content based on state
        return Container();
      },
    );
  }
}

//? Stateless ful validation implementation
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

//? Synrg Analytics
void dummy() {
  // Log a custom event
  SynrgAnalytics.instance.logEvent(
    'sign_up_button_click',
    {'method': 'email_sign_up'},
  );

  // Set a user property
  SynrgAnalytics.instance.setUserProperty(
    name: 'favorite_color',
    value: 'blue',
  );

  // Set the user ID
  SynrgAnalytics.instance.setUserId('user123');

  // Log a screen view
  SynrgAnalytics.instance.logScreenView(
    'HomePage',
    parameters: {'engagement_time': '10 seconds'},
  );
}

//? Synrg Crashlytics
void dummy2() {
  // Log an error
  try {
    // Your code that might throw an exception
  } catch (e, stackTrace) {
    SynrgCrashlytics.instance.logError(
      e as Exception,
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
    print('File uploaded: $downloadUrl');
  }

  // Download a file
  final downloadedFile = await SynrgStorage.instance.downloadFile(
    'uploads/file.jpg',
    'path/to/save/file.jpg',
  );
  if (downloadedFile != null) {
    print('File downloaded to: ${downloadedFile.path}');
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
  print(welcomeMessage);

  // Retrieve a boolean value
  final featureEnabled = SynrgRemoteConfig.instance.getBool('feature_enabled');
  print(featureEnabled ? 'Feature is enabled' : 'Feature is disabled');
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
    print(snapshot.value);
  }

  // Listen to data changes
  SynrgRealtimeDatabase.instance.listenToData('users/user1', (snapshot) {
    print('Data changed: ${snapshot.value}');
  });

  // Update data
  await SynrgRealtimeDatabase.instance.updateData('users/user1', {'age': 31});

  // Delete data
  await SynrgRealtimeDatabase.instance.deleteData('users/user1');
}
