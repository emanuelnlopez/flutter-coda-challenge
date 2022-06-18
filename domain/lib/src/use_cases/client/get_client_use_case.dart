import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class GetClientUseCase extends UseCase<Client> {
  GetClientUseCase({required ClientRepository clientRepository})
      : _clientRepository = clientRepository;

  final ClientRepository _clientRepository;

  @override
  Future<Either<Failure, Client>> execute({
    required Map<String, dynamic> arguments,
  }) async {
    try {
      final result = await _clientRepository.getClient(
        arguments[GetClientUseCaseAttributesKeys.clientId],
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

class GetClientUseCaseAttributesKeys {
  static const String clientId = 'clientId';
}
