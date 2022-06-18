import 'dart:convert';
import 'dart:io';

import 'package:data/data.dart';
import 'package:domain/domain.dart';

class UserNetworkRepository implements UserRepository {
  UserNetworkRepository({
    required NetClient networkClient,
  }) : _networkClient = networkClient;

  final NetClient _networkClient;

  @override
  Future<User> authenticateUser({
    required String email,
    required String password,
  }) async {
    final response = await _networkClient.post(
      AuthenticateUserRequest(
        email: email,
        password: password,
        url: Endpoints.authenticateUser,
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

    return NetworkUser.fromDynamic(
      body['response'],
    );
  }

  @override
  Future<User> createUser({
    required String email,
    required String password,
  }) async {
    final response = await _networkClient.post(
      CreateUserRequest(
        email: email,
        password: password,
        url: Endpoints.createUser,
      ),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }

    final responseBody = json.decode(response.body);

    if (responseBody['success'] == false) {
      throw ServerException(
        code: responseBody['error']['code'],
        message: responseBody['error']['message'],
      );
    }

    return NetworkUser.fromDynamic(
      responseBody['response'],
    );
  }
}
