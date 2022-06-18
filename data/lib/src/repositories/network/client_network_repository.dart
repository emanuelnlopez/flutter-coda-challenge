import 'dart:convert';
import 'dart:io';

import 'package:data/data.dart';
import 'package:domain/domain.dart';

class ClientNetworkRepository implements ClientRepository {
  ClientNetworkRepository({
    required NetClient networkClient,
  }) : _networkClient = networkClient;

  final NetClient _networkClient;

  @override
  Future<bool> deleteClient(int clientId) async {
    final response = await _networkClient.delete(
      DeleteClientRequest(
        clientId: clientId,
        url: Endpoints.deleteClient,
      ),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }

    final body = json.decode(response.body);

    if (body['success'] == false) {
      throw ServerException(
        code: body['error']['code'],
        message: body['error']['message'],
      );
    }

    return true;
  }

  @override
  Future<ClientList> listClients({int? page}) async {
    final response = await _networkClient.post(
      ClientListRequest(
        pageNumber: page ?? 1,
        url: Endpoints.listClients,
      ),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }

    final body = json.decode(response.body);

    if (body['success'] == false) {
      throw ServerException(
        code: body['error']['code'],
        message: body['error']['message'],
      );
    }

    return NetworkClientList.fromDynamic(
      body['response'],
    );
  }

  @override
  Future<Client> saveClient(Client client) async {
    final response = await _networkClient.post(
      SaveClientRequest(
        client: client,
        url: Endpoints.saveClient,
      ),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }

    final body = json.decode(response.body);

    if (body['success'] == false) {
      throw ServerException(
        code: body['error']['code'],
        message: body['error']['message'],
      );
    }

    return NetworkClient.fromDynamic(
      body['response'],
    );
  }
}
