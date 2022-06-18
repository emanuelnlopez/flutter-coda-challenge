import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class SaveClientUseCase extends UseCase<Client> {
  SaveClientUseCase({required ClientRepository clientRepository})
      : _clientRepository = clientRepository;

  final ClientRepository _clientRepository;

  @override
  Future<Either<Failure, Client>> execute({
    required Map<String, dynamic> arguments,
  }) async {
    try {
      final result = await _clientRepository.saveClient(
        arguments[SaveClientUseCaseAttributesKeys.client],
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

class SaveClientUseCaseAttributesKeys {
  static const String client = 'client';
}
