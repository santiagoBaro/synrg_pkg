import 'package:firebase_auth/firebase_auth.dart';
import 'package:synrg/src/_internal.dart';
import 'package:synrg/src/analytics.dart';
import 'package:synrg/src/crashlytics.dart';
import 'package:synrg/src/indexer.dart';
import 'package:synrg/src/session/profile.dart';

/// Handles user authentication state
class SynrgAuth {
  ///
  factory SynrgAuth({Indexer<SynrgProfile>? profileIndex}) {
    if (profileIndex != null) {
      _instance.profileIndex = profileIndex;
    }
    return _instance;
  }

  SynrgAuth._internal();

  static final SynrgAuth _instance = SynrgAuth();

  /// Indexer where profile data is stored
  Indexer<SynrgProfile>? profileIndex;

  ///
  User? user;
  SynrgProfile? _profile;
  DateTime _lastUpdate = DateTime.now();

  /// current user id
  String? userId;

  /// current user access token
  String? accessToken;

  /// User sign in with email and password
  Future<void> signIn(String email, String password) async {
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
    userId = user!.uid;
    final tokenResult = await user!.getIdTokenResult();
    accessToken = tokenResult.token;
    await setUserId(id: user!.uid);
  }

  /// User registration with email and password
  Future<void> register(String email, String password) async {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
    userId = user!.uid;
    await setUserId(id: user!.uid);
  }

  /// User sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    user = null;
    userId = null;
    await setUserId();
  }

  /// Get the current user´s profile
  Future<SynrgProfile?> profile() async {
    // if the profile is still fresh return without making a backend request
    if (_profile != null && _profile!.id == user!.uid) {
      final currentTime = DateTime.now();
      if (currentTime.difference(_lastUpdate).inMinutes < 1) {
        return _profile;
      }
    }
    // otherwise call firestore profile table
    _lastUpdate = DateTime.now();
    return profileIndex!.get(user!.uid);
  }
}
