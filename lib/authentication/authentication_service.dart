import 'package:dart_extras/dart_extras.dart';

import '../authentication/authenticated_user.dart';
import '../services/service.dart';

abstract class AuthenticationService implements Service {
  static final Symbol symbol = Symbol("authentication-service");
  AuthenticationService();
  Future<ResultOf<AuthenticatedUser>> autoSignIn();
  Future<ResultOf<bool>> signOut();
  Future<ResultOf<AuthenticatedUser>> signIn();
  Future<ResultOf<AuthenticatedUser>> signInWith(String email, String password);
}
