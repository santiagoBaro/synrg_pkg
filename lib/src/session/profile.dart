import 'package:synrg/src/class.dart';
import 'package:synrg/synrg.dart';

///
class Location {
  /// Constructor for the Location class.
  const Location({
    this.address = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.postalCode = '',
  });

  /// Converts a map to a Location object.
  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      postalCode: map['postalCode'] as String,
    );
  }

  ///
  final String address;

  ///
  final String city;

  ///
  final String state;

  ///
  final String country;

  ///
  final String postalCode;

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
}

///
abstract class SynrgProfile extends SynrgClass {
  ///
  const SynrgProfile({
    super.id = '',
    super.parent,
    this.name = '',
    this.username = '',
    this.email = '',
    this.dateOfBirth,
    this.gender = '',
    this.location = const Location(),
    this.interests = const [],
    this.preferences = const {},
    this.purchaseHistory = const [],
    this.activityHistory = const [],
    this.additionalRequiredArguments = const [],
    this.isLocationRequired = false,
  });

  /// The user's name.
  final String name;

  /// The user's username.
  final String username;

  /// The user's email address.
  final String email;

  /// The user's date of birth.
  final DateTime? dateOfBirth;

  /// The user's gender.
  final String gender;

  /// The user's location.
  final Location location;

  /// The user's interests.
  final List<String> interests;

  /// The user's preferences.
  final Map<String, dynamic> preferences;

  /// The user's purchase history.
  final List<String> purchaseHistory;

  /// The user's activity history.
  final List<String> activityHistory;

  /// Additional arguments that may be present in the profile.
  final List<String> additionalRequiredArguments;

  /// Has to check for location in (is_complete) flow
  final bool isLocationRequired;

  /// Checks for the user´s basic profile information
  bool isComplete() {
    if (name.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        dateOfBirth == null ||
        gender.isEmpty) {
      return false;
    }
    if (isLocationRequired && location == const Location()) {
      return false;
    }
    if (additionalRequiredArguments.isNotEmpty) {
      // add additional values check
    }
    return true;
  }

  /// this method tries to get the profiles data from FirebaseAUth´s User
  void getData() {
    // final user = SynrgAuth.instance.user;
    // if (user != null) {
    //   copyWith(
    //     name: user.displayName ?? '',
    //     email: user.email ?? '',
    //     dateOfBirth: user.metadata.creationTime,
    //     gender: user.photoURL ?? '',
    //   );
    // }
  }
}
