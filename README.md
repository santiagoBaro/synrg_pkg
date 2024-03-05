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

## Synrg Storage

This SynrgStorage class provides basic functionality for uploading, downloading, and deleting files in Firebase Cloud Storage. It abstracts some of the complexities associated with these operations, offering a simpler interface for performing common tasks.

- The uploadFile method uploads a file to a specified path within Cloud Storage and returns the download URL of the uploaded file.
- The downloadFile method downloads a file from Cloud Storage to a specified local path on the device.
- The deleteFile method deletes a file at a specified path within Cloud Storage.

---

## Synrg Realtime Database

Here's a quick overview of how you might use each method in the SynrgDatabase class:

- Writing Data: Call writeData with a path and a map of data to write or overwrite data at that path.
- Reading Data: Use readData to asynchronously fetch data from a given path. This method returns a snapshot containing the data.
- Listening to Data: To get real-time updates, use listenToData. Provide a callback function that handles data changes.
- Updating Data: Use updateData to modify existing data at a given path without overwriting it entirely.
- Deleting Data: Call deleteData to remove data at a specified path.

This class is designed to be a starting point. Depending on your application's needs, you might want to expand this class with additional error handling, implement more sophisticated data transformation logic, or include other Firebase Realtime Database features.

---

## Synrg Analytics

Here's how you can use the SynrgAnalytics class in your Flutter app to log events, set user properties, and more:

- Log Custom Events: Call logEvent with an event name and, optionally, a map of parameters to log custom events.
- Set User Properties: Use setUserProperty to set attributes related to the user, such as preferences or demographics.
- Set User ID: Use setUserId to assign a unique ID to a user. This is useful for tracking user behavior across sessions.
- Track Screen Views: Call setCurrentScreen to log the screen views within your app, helping you understand which screens are the most visited and engaging.

---

## Synrg Performance

- Custom Traces: Use startTrace to begin a new custom trace, perform the operations you want to measure, and then use stopTrace to end the trace. Custom traces allow you to measure the time taken by specific operations or code sections in your app.
- Metric Increment: If you have counters or other metrics that you want to track within a trace, use incrementMetric.
- Set Trace Attributes: Use setAttribute to add custom metadata to your traces, which can help with filtering and analyzing performance data in the Firebase console.
- HTTP Monitoring: Use startHttpMetric and stopHttpMetric to manually track HTTP requests. This is useful for measuring the performance of network requests not automatically captured by Firebase.
This wrapper class simplifies the interaction with Firebase Performance Monitoring by abstracting some of the setup and management of traces and metrics. You can extend this class further based on your specific performance monitoring needs.

---

## Synrg Crashlytics

- Log Errors: Use logError to report exceptions and errors that you catch in your app. You can include a reason and the stack trace for deeper analysis.
- Custom Keys: With setCustomKey, you can add key-value pairs to your reports, which can help you filter and segment issues in the Firebase console.
- User Identifiers: Setting a user identifier with setUserIdentifier can help you track which users are affected by crashes.
- Log Messages: The logMessage method allows you to include custom log messages in your crash reports, which can provide context about what was happening in your app leading up to an issue.
- Enable/Disable Reporting: Use setCrashlyticsCollectionEnabled to toggle crash report collection. This can be useful for development builds or to comply with user preferences.

This wrapper class simplifies the interaction with Firebase Crashlytics, making it more convenient to add detailed information to your crash reports. By effectively utilizing these capabilities, you can gain valuable insights into the stability of your app and identify areas for improvement.

---

## Synrg Remote Config

1. Initialization: Call initialize early in your app's lifecycle, preferably right after initializing Firebase. You can pass default values for your parameters as a Map. This setup ensures that Remote Config has sensible defaults before fetching updates.

2. Fetching Parameters: Use fetchAndActivate to fetch the latest configuration values from Firebase and activate them. This method can be called at strategic points in your app, such as at startup or when the app regains focus, to ensure your app is using the most recent configuration.

3. Accessing Values: Use getBool, getInt, getDouble, and getString to access configuration values by key. These methods allow you to retrieve the appropriate data types stored in Remote Config.

This wrapper class simplifies interaction with Firebase Remote Config, making it more convenient to manage your app's remote configuration. It encapsulates common tasks, such as initializing Remote Config with default values, fetching the latest configurations, and accessing these values within your app.

---

## Continuous Integration 🤖

Synrg comes with a built-in [GitHub Actions workflow][github_actions_link] powered by [Very Good Workflows][very_good_workflows_link] but you can also add your preferred CI/CD solution.

Out of the box, on each pull request and push, the CI `formats`, `lints`, and `tests` the code. This ensures the code remains consistent and behaves correctly as you add functionality or make changes. The project uses [Very Good Analysis][very_good_analysis_link] for a strict set of analysis options used by our team. Code coverage is enforced using the [Very Good Workflows][very_good_coverage_link].

---

## Running Tests 🧪

For first time users, install the [very_good_cli][very_good_cli_link]:

```sh
dart pub global activate very_good_cli
```

To run all unit tests:

```sh
very_good test --coverage
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```

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
