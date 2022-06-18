import 'package:crud/src/core/core.dart';
import 'package:domain/domain.dart';

enum CreateUserViewState {
  completed,
  error,
  initial,
  loading,
}

class CreateUserViewModel extends ViewModel<CreateUserViewState> {
  CreateUserViewModel({
    required CreateUserUseCase createUserUseCase,
  })  : _createUserUseCase = createUserUseCase,
        super(CreateUserViewState.initial);

  final CreateUserUseCase _createUserUseCase;

  late User _user;

  User get user => _user;

  void createUser({
    required String email,
    required String password,
  }) async {
    setState(CreateUserViewState.loading);

    final response = await _createUserUseCase.execute(
      arguments: {
        CreateUserUseCaseAttributesKeys.email: email,
        CreateUserUseCaseAttributesKeys.password: password,
      },
    );

    response.fold(
      (failure) => setState(
        CreateUserViewState.error,
        description: failure.message,
      ),
      (user) {
        _user = user;
        setState(CreateUserViewState.completed);
      },
    );
  }
}
