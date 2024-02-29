import 'package:firebase_auth/firebase_auth.dart';
import 'package:synrg/src/indexer.dart';
import 'package:synrg/src/session/profile.dart';

/// Handles user authentication state
class SynrgAuth {
  ///
  factory SynrgAuth() {
    return _instance;
  }
  SynrgAuth._internal(this.profileIndex);
  static final SynrgAuth _instance = SynrgAuth();

  /// Indexer where profile data is stored
  Indexer<SynrgProfile>? profileIndex;

  ///
  User? user;
  SynrgProfile? _profile;
  DateTime _lastUpdate = DateTime.now();

  /// User sign in with email and password
  Future<void> signIn(String email, String password) async {
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
  }

  /// User registration with email and password
  Future<void> register(String email, String password) async {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
  }

  /// User sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    user = null;
  }

  /// Get the current user´s profile

  Future<SynrgProfile?> profile() async {
    if (profileIndex == null) {
      return null;
    }
    if (_profile != null && _profile!.id == user!.uid) {
      final currentTime = DateTime.now();
      if (currentTime.difference(_lastUpdate).inHours < 1) {
        return _profile;
      }
    }
    _lastUpdate = DateTime.now();
    return profileIndex!.get(user!.uid);
  }
}
