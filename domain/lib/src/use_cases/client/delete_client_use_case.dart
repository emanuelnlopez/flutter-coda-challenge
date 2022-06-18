import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class DeleteClientUseCase extends UseCase<bool> {
  DeleteClientUseCase({required ClientRepository clientRepository})
      : _clientRepository = clientRepository;

  final ClientRepository _clientRepository;

  @override
  Future<Either<Failure, bool>> execute({
    required Map<String, dynamic> arguments,
  }) async {
    try {
      final result = await _clientRepository.deleteClient(
        arguments[DeleteClientUseCaseAttributesKeys.clientId],
      );

      return Right(result);
    } on ServerException catch (se) {
      return Left(Failure(
        code: se.code,
        message: se.message,
      ));
    } on Exception catch (_) {
      return Left(
        Failure(message: 'Unknown Error'),
      );
    }
  }
}

class DeleteClientUseCaseAttributesKeys {
  static const String clientId = 'clientId';
}
