# Synrg

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

A Very Good Project created by Very Good CLI.

## Installation 💻

**❗ In order to start using Synrg you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Install via `flutter pub add`:

```sh
dart pub add synrg
```

---

## Quick Start

1. Create Firebase Project

   - Enable Authentication by email
   - Enable Analytics
   - Enable PerformanceMonitoring
   - Enable Crashlytics
   - Enable Firestore
   - Enable Storage
   - Enable Hosting
   - Enable RealTimeDatabase
   - Enable RemoteConfig

2. Download firebase_options.dart file and paste it into lib folder

3. Initialize Firebase in app

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseCrashlytics.instance.crash();

  runApp(const MyApp());
}
```

## Overview

This package is meant to facilitate the development of projects that use BLoC and Firebase architecture.
It extends the functionality of already existing packages to out of the box

## Authentication

SynrgAuth centralizes the authentication management.
It has an optional attribute of type SynrgIndex\<SynrgProfile\>. If set it will add the functionality of getting the current users profile.
SynrgProfile is an abstract class with the most commonly used attributes, it extends the base SynrgClass class to enable SynrgIndex functionality.
The profile will be stored in a table and handled like ant other SynrgClass

The class has the attributes:

- user User?
- userId String?
- accessToken String?

It has the methods:

- login (email String, password String)
- register (email String, password String)
- logout ()
- profile () SynrgProfile : if index not null it returns the current users Profile.

```dart
final profileIndex = Indexer<Profile>('projects', Profile.fromMap);

class Profile extends SynrgProfile {
    Profile(super.id);

    List<Project> projects;

    ...
}

final auth = SynrgAuth(profileIndex: profileIndex);

await auth.signIn(event.email, event.password);
await auth.register(event.email, event.password);
await auth.signOut();
final profile = await auth.profile();

```

## BLoC Helpers

### State

SynrgState is the base that all BLoC States should extend to have the Alerts and Analytics functionality.
It has a nullable BlocAlert attribute that the provider uses to show alerts to the user

The toMap and toString methods should be overwritten. This help with the analytics

It has a basic copyWith method to handle the alerts but it should be overwritten if the state has parameters

```dart
part of 'session_bloc.dart';

@immutable
abstract class SynrSessionState extends SynrgState {

  SynrSessionState({super.alert});
}

final class SynrProfileViewState extends SynrSessionState {

  SynrProfileViewState(this.profile, {super.alert});


  final SynrgProfile profile;

  @override
  Map<String, dynamic> toMap() {
    return {
      'profile': profile.toMap(),
    };
  }

  @override
  String toString() => 'SynrProfileViewState';
}
```

### BloC Provider

SynrgProvider extends the functionality of the BlocConsumer, it passes the builder and the bloc as a parameter and adds a listener with the logic to show alerts to the user, only possible if the bloc states extend SynrgState

For each state change it logs an event in SynrgAnalytics with the state´s name as a key and the parameters

```dart
class SynrgSessionProvider extends StatelessWidget {

  const SynrgSessionProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return SynrgBlocProvider<SynrSessionBloc>(
      bloc: SynrSessionBloc(),
      builder: (context, state) {
        if (state is SynrSessionLoadingState) {
          return const Loading();
        }
        if (state is SynrNotAuthenticatedState) {
          return NotAuthenticated();
        }
        if (state is SynrProfileFormState) {
          return SynrgProfileForm();
        }
        if (state is SynrProfileViewState) {
          return const SynrgProfileView();
        }
        return Container();
      },
    );
  }
}
```

### BLoC Alert

Class to facilitate the emission of QuickAlert. If the BLoC´s state extends SynrgState, by emitting a new state with alert: BlocAlert() it will show the user a pop up with the message

BlocAlert model:

- message of type String
- title of type String?
- level of type QuickAlertType

```dart
SynrSessionBloc
    ...

    on<SynrLogin>((event, emit) async {
      try {
        await auth.signIn(event.email, event.password);
      } catch (error) {
        emit(
          SynrNotAuthenticatedState(
            alert: BlocAlert(
              title: 'Sign In Error',
              message: error.toString(),
              level: QuickAlertType.error,
            ),
          ),
        );
      }
    });
```

## Functions

SynrgFunctions is a facilitator to the remote functions call.
It standardizes the format and maps the response object.

```dart
final payments = SynrgFunction<Project>('payments', Project.fromMap);
final Project response = payments.call({'id': 'random_id'});
```

---

## Indexer

SynrgIndexer is a in sorts a repository, it handles the logic for the request to the Database.
Other than simplifying the logic, it also handles the mapping of the models.

- get (String id): get item by id
- batchGet (List\<String\> ids): handle for the case where many items are being queried
- query (String field, Query query): it handles more specific queries based on an items field
- save (): it persists the changes to the database

```dart
final projectIndex = SynrgIndexer<Project>('projects', Project.fromMap);
final Project project = projectIndex.get('project-id');
final List<Project> projectList = projectIndex.batchGet([
  'project-id-1',
  'project-id-2',
  'project-id-3',
]);
final List<Project> projectQuery = projectIndex.query(
  field: 'type',
  isEqualTo: 'Ongoing',
);
```

---

## Storage

This SynrgStorage class provides basic functionality for uploading, downloading, and deleting files in Firebase Cloud Storage. It abstracts some of the complexities associated with these operations, offering a simpler interface for performing common tasks.

- The uploadFile method uploads a file to a specified path within Cloud Storage and returns the download URL of the uploaded file.
- The downloadFile method downloads a file from Cloud Storage to a specified local path on the device.
- The deleteFile method deletes a file at a specified path within Cloud Storage.

_All methods are integrated with Crashlytics and Performance Monitoring to log metrics_

```dart
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
```

---

## Realtime Database

Here's a quick overview of how you might use each method in the SynrgDatabase class:

- Writing Data: Call writeData with a path and a map of data to write or overwrite data at that path.
- Reading Data: Use readData to asynchronously fetch data from a given path. This method returns a snapshot containing the data.
- Listening to Data: To get real-time updates, use listenToData. Provide a callback function that handles data changes.
- Updating Data: Use updateData to modify existing data at a given path without overwriting it entirely.
- Deleting Data: Call deleteData to remove data at a specified path.

_All methods are integrated with Crashlytics and Performance Monitoring to log metrics_

This class is designed to be a starting point. Depending on your application's needs, you might want to expand this class with additional error handling, implement more sophisticated data transformation logic, or include other Firebase Realtime Database features.

```dart
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
```

---

## Analytics

Here's how you can use the SynrgAnalytics class in your Flutter app to log events, set user properties, and more:

- Log Custom Events: Call logEvent with an event name and, optionally, a map of parameters to log custom events.
- Set User Properties: Use setUserProperty to set attributes related to the user, such as preferences or demographics.
- Set User ID: Use setUserId to assign a unique ID to a user. This is useful for tracking user behavior across sessions.
- Track Screen Views: Call setCurrentScreen to log the screen views within your app, helping you understand which screens are the most visited and engaging.

```dart
  // Log a custom event
  await SynrgAnalytics.instance.logEvent('test_event', {'parameter': 'value'});

  // Set a user property
  await SynrgAnalytics.instance
      .setUserProperty(name: 'user_type', value: 'premium');

  // Set the user ID
  await SynrgAnalytics.instance.setUserId('user123');

  // Log a screen view
  await SynrgAnalytics.instance.logScreenView('HomeScreen');
```

---

## Performance

- Custom Traces: Use startTrace to begin a new custom trace, perform the operations you want to measure, and then use stopTrace to end the trace. Custom traces allow you to measure the time taken by specific operations or code sections in your app.
- Metric Increment: If you have counters or other metrics that you want to track within a trace, use incrementMetric.
- Set Trace Attributes: Use setAttribute to add custom metadata to your traces, which can help with filtering and analyzing performance data in the Firebase console.
- HTTP Monitoring: Use startHttpMetric and stopHttpMetric to manually track HTTP requests. This is useful for measuring the performance of network requests not automatically captured by Firebase.
  This wrapper class simplifies the interaction with Firebase Performance Monitoring by abstracting some of the setup and management of traces and metrics. You can extend this class further based on your specific performance monitoring needs.

```dart
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
```

---

## Crashlytics

- Log Errors: Use logError to report exceptions and errors that you catch in your app. You can include a reason and the stack trace for deeper analysis.
- Custom Keys: With setCustomKey, you can add key-value pairs to your reports, which can help you filter and segment issues in the Firebase console.
- User Identifiers: Setting a user identifier with setUserIdentifier can help you track which users are affected by crashes.
- Log Messages: The logMessage method allows you to include custom log messages in your crash reports, which can provide context about what was happening in your app leading up to an issue.
- Enable/Disable Reporting: Use setCrashlyticsCollectionEnabled to toggle crash report collection. This can be useful for development builds or to comply with user preferences.

This wrapper class simplifies the interaction with Firebase Crashlytics, making it more convenient to add detailed information to your crash reports. By effectively utilizing these capabilities, you can gain valuable insights into the stability of your app and identify areas for improvement.

```dart
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
```

---

## Remote Config

1. Initialization: Call initialize early in your app's lifecycle, preferably right after initializing Firebase. You can pass default values for your parameters as a Map. This setup ensures that Remote Config has sensible defaults before fetching updates.

2. Fetching Parameters: Use fetchAndActivate to fetch the latest configuration values from Firebase and activate them. This method can be called at strategic points in your app, such as at startup or when the app regains focus, to ensure your app is using the most recent configuration.

3. Accessing Values: Use getBool, getInt, getDouble, and getString to access configuration values by key. These methods allow you to retrieve the appropriate data types stored in Remote Config.

_All methods are integrated with Crashlytics and Performance Monitoring to log metrics_

This wrapper class simplifies interaction with Firebase Remote Config, making it more convenient to manage your app's remote configuration. It encapsulates common tasks, such as initializing Remote Config with default values, fetching the latest configurations, and accessing these values within your app.

```dart
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
```

## Validations

```dart
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
```

---

[flutter_install_link]: https://docs.flutter.dev/get-started/install
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://pub.dev/packages/very_good_cli
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
