import 'package:crud/src/core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

enum LoginViewState {
  completed,
  error,
  initial,
  loading,
}

class LoginViewModel extends ViewModel<LoginViewState> {
  LoginViewModel({
    required AuthenticateUserUseCase authenticateUserUseCase,
    required GlobalKey<NavigatorState> navigatorKey,
    required StoreJwtUseCase storeJwtUseCase,
  })  : _authenticateUserUseCase = authenticateUserUseCase,
        _navigatorKey = navigatorKey,
        _storeJwtUseCase = storeJwtUseCase,
        super(LoginViewState.initial);

  final AuthenticateUserUseCase _authenticateUserUseCase;
  final GlobalKey<NavigatorState> _navigatorKey;
  final StoreJwtUseCase _storeJwtUseCase;

  void login({
    required String email,
    required String password,
  }) async {
    setState(LoginViewState.loading);

    final response = await _authenticateUserUseCase.execute(
      arguments: {
        AuthenticateUserUseCaseAttributesKeys.email: email,
        AuthenticateUserUseCaseAttributesKeys.password: password,
      },
    );

    response.fold(
      (failure) => setState(
        LoginViewState.error,
        description: failure.message,
      ),
      (userProfile) => _storeJwt(userProfile.accessToken!.token!),
    );
  }

  void _storeJwt(String token) async {
    final result = await _storeJwtUseCase.execute(
      arguments: {
        StoreJwtUseCaseUseCaseAttributesKeys.token: token,
      },
    );
    result.fold(
      (failure) => setState(
        LoginViewState.error,
        description: failure.message,
      ),
      (success) => _navigatorKey.currentState!.pushReplacementNamed(
        NamedRoute.home,
      ),
    );
  }
}
