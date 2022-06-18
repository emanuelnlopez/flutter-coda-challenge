import 'package:crud/src/core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

enum SplashViewState {
  loading,
}

class SplashViewModel extends ViewModel<SplashViewState> {
  SplashViewModel({
    required GetJwtUseCase getJwtUseCase,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _getJwtUseCase = getJwtUseCase,
        _navigatorKey = navigatorKey,
        super(SplashViewState.loading);

  final GetJwtUseCase _getJwtUseCase;
  final GlobalKey<NavigatorState> _navigatorKey;

  void checkAccessToken() async {
    final result = await _getJwtUseCase.execute(
      arguments: {},
    );

    await result.fold(
      (failure) {
        _navigatorKey.currentState!.pushReplacementNamed(NamedRoute.login);
      },
      (jwt) {
        var nextScreen = NamedRoute.login;
        if (jwt?.valid == true) {
          nextScreen = NamedRoute.home;
        }
        _navigatorKey.currentState!.pushReplacementNamed(nextScreen);
      },
    );
  }
}
