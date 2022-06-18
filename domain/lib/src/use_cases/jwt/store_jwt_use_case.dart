import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class StoreJwtUseCase extends UseCase<bool> {
  StoreJwtUseCase({required SecureStorage secureStorage})
      : _secureStorage = secureStorage;

  final SecureStorage _secureStorage;

  @override
  Future<Either<Failure, bool>> execute({
    required Map<String, dynamic> arguments,
  }) async {
    try {
      await _secureStorage.storeJwt(
        arguments[StoreJwtUseCaseUseCaseAttributesKeys.token],
      );

      return Right(true);
    } on Exception catch (_) {
      return Left(
        Failure(message: 'Error while trying to store access token'),
      );
    }
  }
}

class StoreJwtUseCaseUseCaseAttributesKeys {
  static const String token = 'token';
}
