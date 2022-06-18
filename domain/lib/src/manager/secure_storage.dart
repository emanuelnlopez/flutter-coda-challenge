import 'package:domain/domain.dart';

abstract class SecureStorage {
  Future<void> clearJwt();

  Future<Jwt?> getJwt();

  Future<void> storeJwt(String token);
}
