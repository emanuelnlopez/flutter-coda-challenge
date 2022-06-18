import 'package:crud/src/core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

enum HomeViewState {
  completed,
  error,
  initial,
  loading,
}

class HomeViewModel extends ViewModel<HomeViewState> {
  HomeViewModel({
    required DeleteClientUseCase deleteClientUseCase,
    required ListClientsUseCase listClientsUseCase,
    required SaveClientUseCase saveClientUseCase,
  })  : _deleteClientUseCase = deleteClientUseCase,
        _listClientsUseCase = listClientsUseCase,
        _saveClientUseCase = saveClientUseCase,
        super(HomeViewState.initial);

  final List<Client> _clients = [];
  final DeleteClientUseCase _deleteClientUseCase;
  final ListClientsUseCase _listClientsUseCase;
  final SaveClientUseCase _saveClientUseCase;

  int _currentPage = 0;
  int? _lastPage;

  List<Client> get clients => _clients;
  bool get isMoreDataAvailable => _currentPage < _lastPage!;

  void deleteClient(int clientId) async {
    setState(HomeViewState.loading);

    final result = await _deleteClientUseCase.execute(
      arguments: {
        DeleteClientUseCaseAttributesKeys.clientId: clientId,
      },
    );

    result.fold(
      (failure) => setState(
        HomeViewState.error,
        description: failure.message,
      ),
      (success) {
        _clients.clear();
        _currentPage = 0;
        fetchClients();
      },
    );
  }

  void fetchClients() async {
    if (_currentPage != _lastPage) {
      setState(HomeViewState.loading);

      final result = await _listClientsUseCase.execute(
        arguments: {
          ListClientsUseCaseAttributesKeys.page: _currentPage + 1,
        },
      );

      result.fold(
        (failure) => setState(
          HomeViewState.error,
          description: failure.message,
        ),
        (clientList) {
          _currentPage = clientList.currentPage;
          _lastPage = clientList.lastPage;
          _clients.addAll(clientList.data);
          setState(HomeViewState.completed);
        },
      );
    }
  }

  void saveClient(Client client) async {
    setState(HomeViewState.loading);

    final result = await _saveClientUseCase.execute(
      arguments: {
        SaveClientUseCaseAttributesKeys.client: client,
      },
    );

    result.fold(
      (failure) => setState(
        HomeViewState.error,
        description: failure.message,
      ),
      (success) {
        _clients.clear();
        _currentPage = 0;
        fetchClients();
      },
    );
  }
}
