import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

class AuthenticateUserUseCase extends UseCase<User> {
  AuthenticateUserUseCase({required UserRepository userRepository})
      : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, User>> execute({
    required Map<String, dynamic> arguments,
  }) async {
    try {
      final result = await _userRepository.authenticateUser(
        email: arguments[AuthenticateUserUseCaseAttributesKeys.email],
        password: arguments[AuthenticateUserUseCaseAttributesKeys.password],
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

class AuthenticateUserUseCaseAttributesKeys {
  static const String email = 'email';
  static const String password = 'password';
}
