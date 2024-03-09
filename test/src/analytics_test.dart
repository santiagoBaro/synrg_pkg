// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:synrg/src/analytics.dart';
// import 'package:synrg/src/mocks/analytics_test.mocks.dart';

// @GenerateMocks([FirebaseAnalytics])
// void main() {
//   group('SynrgAnalytics', () {
//     late SynrgAnalytics analytics;
//     late MockFirebaseAnalytics mockFirebaseAnalytics;

//     setUp(() {
//       analytics = SynrgAnalytics.instance;
//       mockFirebaseAnalytics = MockFirebaseAnalytics();
//     });

//     test('logEvent should call logEvent on FirebaseAnalytics', () async {
//       final parameters = {'param1': 'value1'}; // Modifiable map
//       await analytics.logEvent('test_event', parameters);
//       verify(mockFirebaseAnalytics.logEvent(
//         name: 'test_event',
//         parameters: anyNamed('parameters'),
//       )).called(1);
//     });

//     test('setUserProperty should call setUserProperty on FirebaseAnalytics',
//         () async {
//       await analytics.setUserProperty(name: 'user_prop', value: 'value');
//       verify(mockFirebaseAnalytics.setUserProperty(
//               name: 'user_prop', value: 'value'))
//           .called(1);
//     });

//     // Add similar tests for other methods
//   });
// }
