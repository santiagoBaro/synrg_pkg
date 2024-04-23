import 'package:synrg/src/class.dart';
import 'package:synrg/src/session/auth.dart';

///
class Location {
  ///
  String address = '';

  ///
  String city = '';

  ///
  String state = '';

  ///
  String country = '';

  ///
  String postalCode = '';

  /// Constructor for the Location class.
  Location({
    this.address = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.postalCode = '',
  });

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          address == other.address &&
          city == other.city &&
          state == other.state &&
          country == other.country &&
          postalCode == other.postalCode;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode =>
      address.hashCode ^
      city.hashCode ^
      state.hashCode ^
      country.hashCode ^
      postalCode.hashCode;

  /// Converts a map to a Location object.
  factory Location.fromMap(Map<String, dynamic> map) {
    return Location()
      ..address = map['address'] as String
      ..city = map['city'] as String
      ..state = map['state'] as String
      ..country = map['country'] as String
      ..postalCode = map['postalCode'] as String;
  }
}

///
abstract class SynrgProfile extends SynrgClass {
  ///
  SynrgProfile({super.id});

  /// The user's name.
  String name = '';

  /// The user's username.
  String username = '';

  /// The user's email address.
  String email = '';

  /// The user's date of birth.
  DateTime? dateOfBirth;

  /// The user's gender.
  String gender = '';

  /// The user's location.
  Location location = Location();

  /// The user's interests.
  List<String> interests = [];

  /// The user's preferences.
  Map<String, dynamic> preferences = {};

  /// The user's purchase history.
  List<String> purchaseHistory = [];

  /// The user's activity history.
  List<String> activityHistory = [];

  /// Additional arguments that may be present in the profile.
  List<String> additionalRequiredArguments = [];

  /// Has to check for location in (is_complete) flow
  bool isLocationRequired = false;

  /// Checks for the user´s basic profile information
  bool isComplete() {
    if (name.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        dateOfBirth == null ||
        gender.isEmpty) {
      return false;
    }
    if (isLocationRequired && location == Location()) {
      return false;
    }
    if (additionalRequiredArguments.isNotEmpty) {
      // add additional values check
    }
    return true;
  }

  /// this method tries to get the profiles data from FirebaseAUth´s User
  void getData() {
    final user = SynrgAuth.instance.user;
    if (user != null) {
      name = user.displayName ?? '';
      email = user.email ?? '';
      dateOfBirth = user.metadata.creationTime;
      gender = user.photoURL ?? '';
    }
  }
}
