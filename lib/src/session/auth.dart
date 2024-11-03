import 'package:firebase_auth/firebase_auth.dart';
import 'package:synrg/src/_internal.dart';
import 'package:synrg/synrg.dart';

/// Handles user authentication state
class SynrgAuth {
  // Private constructor
  SynrgAuth._privateConstructor(this._auth, this.profileIndex);

  static late final SynrgAuth _instance;

  /// Provides a global access point to the SynrgAuth instance
  static SynrgAuth get instance => _instance;

  /// Method to initialize the SynrgAuth singleton with a profileIndex.
  static void initialize(SynrgIndexer<SynrgProfile>? profileIndex) {
    _instance =
        SynrgAuth._privateConstructor(FirebaseAuth.instance, profileIndex);
  }

  /// Indexer where profile data is stored
  SynrgIndexer<SynrgProfile>? profileIndex;
  final _performance = SynrgPerformance.instance;
  final FirebaseAuth _auth;

  ///
  User? user;

  /// Current user profile
  SynrgProfile? profile;

  /// current user id
  String? userId;

  /// current user access token
  String? accessToken;

  /// Initialize authentication
  void init() {
    user = _auth.currentUser;
    if (user != null) {
      userId = user!.uid;
    }
    setUserId(null);
  }

  /// User sign in with email and password
  Future<void> signIn(String email, String password) async {
    final trace = await _performance.startTrace('Sign In');
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      userId = user!.uid;
      final tokenResult = await user!.getIdTokenResult();
      accessToken = tokenResult.token;

      // Refresh profile after login
      await setUserId(user!.uid);
      await refreshProfile();
    } catch (error, stackTrace) {
      SynrgCrashlytics.instance.logError(
        error as Error,
        stackTrace,
        reason: 'Auth Sign In Exception',
      );
    } finally {
      await _performance.stopTrace(trace);
    }
  }

  /// User registration with email and password
  Future<void> register(String email, String password) async {
    final trace = await _performance.startTrace('Register');
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      userId = user!.uid;

      // Refresh profile after registration
      await setUserId(user!.uid);
      await refreshProfile();
    } catch (error, stackTrace) {
      SynrgCrashlytics.instance.logError(
        error as Error,
        stackTrace,
        reason: 'Auth Register Exception',
      );
    } finally {
      await _performance.stopTrace(trace);
    }
  }

  /// User sign out
  Future<void> signOut() async {
    final trace = await _performance.startTrace('Sign Out');
    try {
      await _auth.signOut();
      user = null;
      userId = null;

      // Clear profile on logout
      profile = null;
      await setUserId(null);
    } catch (error, stackTrace) {
      SynrgCrashlytics.instance.logError(
        error as Error,
        stackTrace,
        reason: 'Auth Sign Out Exception',
      );
    } finally {
      await _performance.stopTrace(trace);
    }
  }

  /// Refresh the current user´s profile
  Future<void> refreshProfile() async {
    final trace = await _performance.startTrace('Refresh Profile');
    try {
      if (user != null) {
        profile = await profileIndex!.get(user!.uid);
      }
    } catch (error, stackTrace) {
      SynrgCrashlytics.instance.logError(
        error as Error,
        stackTrace,
        reason: 'Auth Refresh Profile Exception',
      );
    } finally {
      await _performance.stopTrace(trace);
    }
  }
}
