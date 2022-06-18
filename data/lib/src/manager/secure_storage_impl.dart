import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';

class SecureStorageImpl extends SecureStorage {
  SecureStorageImpl() : _secureStorage = FlutterSecureStorage();

  static const _keyJwt = 'key.jwt';

  final Logger _logger = Logger('LocalSecureStorage');
  final FlutterSecureStorage _secureStorage;

  Jwt? _jwt;

  @override
  Future<void> clearJwt() async {
    await reset();
    _jwt = null;
  }

  @override
  Future<Jwt?> getJwt() async {
    String? token;
    if (_jwt == null) {
      token = await _load(key: _keyJwt);
    }

    if (token?.isNotEmpty == true) {
      _jwt = NetworkJwt.fromToken(token);
    }

    return _jwt;
  }

  Future<void> reset() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e, stack) {
      _logger.severe('Exception clearing secure storage', e, stack);
      rethrow;
    }
  }

  @override
  Future<void> storeJwt(String token) async {
    await _save(
      key: _keyJwt,
      value: token,
    );

    _jwt = NetworkJwt.fromToken(token);
  }

  Future<String?> _load({required String key}) async {
    String? result;

    try {
      result = await _secureStorage.read(key: key);
    } catch (e, stack) {
      _logger.severe('Exception loading "$key" from secure storage', e, stack);
      rethrow;
    }

    return result;
  }

  Future<void> _save({
    required String key,
    required String value,
  }) async {
    try {
      await _secureStorage.write(
        key: key,
        value: value,
      );
    } catch (e, stack) {
      _logger.severe('Exception saving "$key" to secure storage', e, stack);
      rethrow;
    }
  }
}
