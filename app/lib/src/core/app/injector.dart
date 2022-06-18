import 'dart:async';

import 'package:crud/src/features/features.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

abstract class Injector {
  CreateUserViewModel get createUserViewModel;

  HomeViewModel get homeViewModel;

  Stream<bool> get initializationStream;

  LoginViewModel get loginViewModel;

  GlobalKey<NavigatorState> get navigatorKey;

  SplashViewModel get splashViewModel;

  void dispose();

  Future<void> initialize();

  bool isInitialized();
}

class DefaultInjector implements Injector {
  final StreamController<bool> _initializationStreamController =
      StreamController<bool>.broadcast();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  late AuthenticateUserUseCase _authenticateUserUseCase;
  late ClientRepository _clientRepository;
  late CreateUserUseCase _createUserUseCase;
  late DeleteClientUseCase _deleteClientUseCase;
  late GetJwtUseCase _getJwtUseCase;
  bool _initialized = false;
  late ListClientsUseCase _listClientsUseCase;
  late NetClient _networkClient;
  late SaveClientUseCase _saveClientUseCase;
  late SecureStorage _secureStorage;
  late StoreJwtUseCase _storeJwtUseCase;
  late UserRepository _userRepository;

  @override
  CreateUserViewModel get createUserViewModel => CreateUserViewModel(
        createUserUseCase: _createUserUseCase,
      );

  @override
  HomeViewModel get homeViewModel => HomeViewModel(
        deleteClientUseCase: _deleteClientUseCase,
        listClientsUseCase: _listClientsUseCase,
        saveClientUseCase: _saveClientUseCase,
      );

  @override
  Stream<bool> get initializationStream =>
      _initializationStreamController.stream;

  @override
  LoginViewModel get loginViewModel => LoginViewModel(
        authenticateUserUseCase: _authenticateUserUseCase,
        navigatorKey: navigatorKey,
        storeJwtUseCase: _storeJwtUseCase,
      );

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  SplashViewModel get splashViewModel => SplashViewModel(
        getJwtUseCase: _getJwtUseCase,
        navigatorKey: navigatorKey,
      );

  @override
  Future<void> initialize() async {
    if (!isInitialized()) {
      _secureStorage = SecureStorageImpl();

      _networkClient = NetClient(
        secureStorage: _secureStorage,
      );

      _clientRepository = ClientNetworkRepository(
        networkClient: _networkClient,
      );

      _userRepository = UserNetworkRepository(
        networkClient: _networkClient,
      );

      _authenticateUserUseCase = AuthenticateUserUseCase(
        userRepository: _userRepository,
      );

      _createUserUseCase = CreateUserUseCase(
        userRepository: _userRepository,
      );

      _deleteClientUseCase = DeleteClientUseCase(
        clientRepository: _clientRepository,
      );

      _getJwtUseCase = GetJwtUseCase(
        secureStorage: _secureStorage,
      );

      _listClientsUseCase = ListClientsUseCase(
        clientRepository: _clientRepository,
      );

      _saveClientUseCase = SaveClientUseCase(
        clientRepository: _clientRepository,
      );

      _storeJwtUseCase = StoreJwtUseCase(
        secureStorage: _secureStorage,
      );

      _initialized = true;
      _initializationStreamController.add(_initialized);
    }
  }

  @override
  void dispose() {
    _initialized = false;
    _initializationStreamController.add(_initialized);
    _initializationStreamController.close();
  }

  @override
  bool isInitialized() => _initialized;
}
