import 'package:dart_extras/dart_extras.dart';

import '../extensions/date_time_extensions.dart';

class AuthenticatedUser extends Cloneable {
  static final AuthenticatedUser empty = AuthenticatedUser();

  bool get isNotEmpty => this != empty;

  /// The provider identifier.
  final String providerId;

  /// The provider’s user ID for the user.
  final String providerUserId;

  final String displayName;
  final String photoUrl;
  final String email;
  final String phoneNumber;

  final DateTime creationTime;
  final DateTime lastSignInTime;
  final bool isAnonymous;
  final bool isEmailVerified;

  AuthenticatedUser({
    this.displayName = "",
    this.photoUrl = "",
    this.email = "",
    this.phoneNumber = "",
    this.isAnonymous = false,
    this.isEmailVerified = false,
    this.providerId = "",
    this.providerUserId = "",
    DateTime? creationTime,
    DateTime? lastSignInTime,
  })  : this.creationTime = creationTime ?? emptyDateTime,
        this.lastSignInTime = lastSignInTime ?? emptyDateTime;

  @override
  AuthenticatedUser clone() {
    return AuthenticatedUser(
        displayName: displayName,
        photoUrl: photoUrl,
        email: email,
        phoneNumber: phoneNumber,
        creationTime: creationTime,
        lastSignInTime: lastSignInTime,
        isAnonymous: isAnonymous,
        isEmailVerified: isEmailVerified);
  }
}
