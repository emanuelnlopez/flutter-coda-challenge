import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

abstract class UseCase<Success> {
  Future<Either<Failure, Success>> execute({
    required Map<String, dynamic> arguments,
  });
}
