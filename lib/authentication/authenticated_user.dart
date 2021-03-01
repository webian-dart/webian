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
    String displayName,
    String photoUrl,
    String email,
    String phoneNumber,
    DateTime creationTime,
    DateTime lastSignInTime,
    bool isAnonymous,
    bool isEmailVerified,
    String providerId,
    String providerUserId,
  })  : this.displayName = displayName ?? "",
        this.photoUrl = photoUrl ?? "",
        this.email = email ?? "",
        this.phoneNumber = phoneNumber ?? "",
        this.creationTime = creationTime ?? emptyDateTime,
        this.lastSignInTime = lastSignInTime ?? emptyDateTime,
        this.isAnonymous = isAnonymous ?? false,
        this.isEmailVerified = isEmailVerified ?? false,
        this.providerId = providerId ?? "",
        this.providerUserId = providerUserId ?? "";

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
