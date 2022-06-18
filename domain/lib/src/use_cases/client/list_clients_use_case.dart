import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class ListClientsUseCase extends UseCase<ClientList> {
  ListClientsUseCase({required ClientRepository clientRepository})
      : _clientRepository = clientRepository;

  final ClientRepository _clientRepository;

  @override
  Future<Either<Failure, ClientList>> execute({
    required Map<String, dynamic> arguments,
  }) async {
    try {
      final result = await _clientRepository.listClients(
        page: arguments[ListClientsUseCaseAttributesKeys.page],
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

class ListClientsUseCaseAttributesKeys {
  static const String page = 'page';
}
