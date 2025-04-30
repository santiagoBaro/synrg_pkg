# 🧠 Synrg

**Synrg** is a comprehensive Flutter utility package that abstracts and unifies Firebase services, modular state management, data modeling, query building, UI feedback, and validation — all with developer experience in mind.

It provides an opinionated architecture for building scalable Flutter apps with:

- Firebase (Auth, Firestore, Storage, Functions, Remote Config, Realtime DB, Analytics, Crashlytics, Performance)
- BLoC integration with enhanced state and UI feedback
- Strongly typed indexing, validation, and serialization logic
- Production-ready UI modal system
- 150+ domain-specific validators

---

## ✨ Features

- ✅ `SynrgBlocProvider` with automatic modal display and analytics
- 🔐 Firebase Authentication & profile management
- 🗃 Firestore abstraction with `SynrgIndexer` and paginated querying
- ⚡ Cloud Functions typed wrapper with result status
- 📁 Firebase Storage simplified upload/download/delete
- 🌐 Firebase Remote Config wrapper
- 🔄 Realtime Database write, update, listen and delete
- 📊 Firebase Analytics & Performance tracing
- 🛠 Crashlytics error logging and custom attributes
- 🔎 Query builder (`QueryFilter`) and parser
- 📦 Abstract base class `SynrgClass` for ID, map, and parent tracking
- 🧪 Extensive validation library for IDs, formats, geo, finance, healthcare, etc.

---

## 📦 Installation

Add dependency

```bash
flutter pub add synrg
```

Add `synrg` to your `pubspec.yaml`:

```yaml
dependencies:
  synrg: ^latest
```

Make sure to initialize Firebase in your project.

---

## 🚀 Getting Started

```dart
import 'package:synrg/synrg.dart';

void main() async {
  await Firebase.initializeApp();

  SynrgCrashlytics.instance.initialize();
  SynrgAuth.initialize(profileIndex);
}
```

---

## 🧩 Modules

### 1. `SynrgBlocProvider`

A wrapper over `BlocProvider` + `BlocConsumer` that listens for modals and analytics automatically.

```dart
SynrgBlocProvider<MyBloc>(
  bloc: MyBloc()..add(MyInitEvent()),
  builder: (context, state) {
    if (state is MyStateReady) {
      return MyPage();
    }
    return CircularProgressIndicator();
  },
);
```

Requires states to extend `SynrgState`:

```dart
class MyState extends SynrgState {
  const MyState({this.modal}) : super(modal: modal);
  final SynrgModal? modal;

  @override
  Map<String, dynamic> toMap() => {...};
}
```

### 2. `SynrgModal`

Show toasts, dialogs, drawers, etc., based on state.

```dart
emit(MyState(modal: SynrgModal(
  message: 'Operation failed',
  level: AlertLevel.error,
  type: SynrgModalType.toast,
)));
```

### 3. `SynrgAuth`

Firebase Authentication + Profile sync

```dart
await SynrgAuth.instance.signIn(email, password);
final user = SynrgAuth.instance.profile;
```

### 4. `SynrgIndexer<T>`

Typed Firestore access

```dart
final index = SynrgIndexer<Project>('projects', Project.fromMap);

final project = await index.get('id123');
await index.save(Project(name: 'New Project'));
```

Supports pagination, filtering, and batch ops.

### 5. `SynrgFunction<T>`

Cloud Functions with result status:

```dart
final fn = SynrgFunction<Project>('getProject', Project.fromMap);
final result = await fn.call({'id': 'abc'});

if (result.status == SynrgFunctionStatus.success) {
  print(result.result?.name);
}
```

### 6. `SynrgStorage`

```dart
final url = await SynrgStorage.instance.uploadFile('path/file.png', file);
await SynrgStorage.instance.deleteFile('path/file.png');
```

### 7. `SynrgRealtimeDatabase`

```dart
await SynrgRealtimeDatabase.instance.writeData('users/1', {'name': 'Ana'});
final snapshot = await SynrgRealtimeDatabase.instance.readData('users/1');
```

### 8. `SynrgRemoteConfig`

```dart
await SynrgRemoteConfig.instance.initialize();
final showBanner = SynrgRemoteConfig.instance.getBool('show_banner');
```

### 9. `SynrgCrashlytics`

```dart
SynrgCrashlytics.instance.logError(error, stackTrace);
SynrgCrashlytics.instance.setUserIdentifier(userId);
```

### 10. `SynrgPerformance`

```dart
final trace = await SynrgPerformance.instance.startTrace('my-trace');
// ... do work
await SynrgPerformance.instance.stopTrace(trace);
```

### 11. `SynrgAnalytics`

```dart
SynrgAnalytics.instance.logEvent('screen_view', {'page': 'home'});
```

### 12. `QueryFilter`

Query utilities for `SynrgIndexer`:

```dart
final filters = [
  QueryFilter('status', isEqualTo: 'active'),
  QueryFilter('price', isLessThanOrEqualTo: 100),
];
await index.query(filters);
```

Supports `.toString()` and `.fromString(...)` for dynamic queries.

### 13. `SynrgClass`

Your models should extend `SynrgClass` for auto-saving and ID handling:

```dart
class Project extends SynrgClass {
  final String name;

  Project({required this.name, super.id});

  @override
  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  factory Project.fromMap(Map<String, dynamic> map) =>
      Project(name: map['name'], id: map['id']);
}
```

---

## 🧪 Validation

Import validators from `synrg/validators.dart` for:

- 📍 Address & Location (zip, city, lat/lng, etc.)
- 💳 Finance (credit card, CVV, IBAN, etc.)
- 📆 Date & Time (HH:mm:ss, timestamp, etc.)
- 📦 Logistics (SKU, barcode, VIN, tracking)
- 🧬 Healthcare (blood type, allergies, medical IDs)
- 🎓 Education (student ID, GPA, course code)
- 🌍 Tech & Network (IPv4/6, MAC, URL, domain, regex, JSON)
- 📄 Files & Content (file size, extension, CSV, Markdown, etc.)

Example:

```dart
TextFormField(
  validator: validateEmailAddress,
)
```

---

## 🔧 Requirements

- Flutter 3.16+
- Firebase (initialized in your app)
- BLoC (optional but recommended)

---

## 🤝 Contributing

PRs welcome! Please open issues for feedback, bugs or ideas.

---

## 📄 License

MIT © [Your Name or Org]
