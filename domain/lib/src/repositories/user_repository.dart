import 'package:domain/domain.dart';

abstract class UserRepository {
  Future<User> authenticateUser({
    required String email,
    required String password,
  });

  Future<User> createUser({
    required String email,
    required String password,
  });
}
