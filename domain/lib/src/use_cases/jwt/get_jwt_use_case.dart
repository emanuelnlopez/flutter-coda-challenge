import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class GetJwtUseCase extends UseCase<Jwt?> {
  GetJwtUseCase({required SecureStorage secureStorage})
      : _secureStorage = secureStorage;

  final SecureStorage _secureStorage;

  @override
  Future<Either<Failure, Jwt?>> execute({
    required Map<String, dynamic> arguments,
  }) async {
    try {
      final jwt = await _secureStorage.getJwt();

      return Right(jwt);
    } on Exception catch (_) {
      return Left(
        Failure(message: 'Error while trying to get access token'),
      );
    }
  }
}
