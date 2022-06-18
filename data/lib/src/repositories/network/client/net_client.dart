import 'dart:io';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;

class NetClient {
  NetClient({required SecureStorage secureStorage})
      : _secureStorage = secureStorage;

  final NetLogger _logger = NetLogger();
  final SecureStorage _secureStorage;

  Future<http.Response> delete(NetworkRequest request) async {
    final requestHeaders = _secure(
      headers: request.headers ?? {},
      token: (await _secureStorage.getJwt())?.token,
    );

    _logger.logRequest(
      headers: requestHeaders,
      method: 'DELETE',
      uri: request.uri,
    );

    final response = await http.delete(
      request.uri,
      headers: requestHeaders,
    );

    _logger.logResponse(
      body: response.body,
      headers: response.headers,
      statusCode: response.statusCode,
    );

    return response;
  }

  Future<http.Response> get(NetworkRequest request) async {
    final requestHeaders = _secure(
      headers: request.headers ?? {},
      token: (await _secureStorage.getJwt())?.token,
    );

    _logger.logRequest(
      headers: requestHeaders,
      method: 'GET',
      uri: request.uri,
    );

    final response = await http.get(
      request.uri,
      headers: requestHeaders,
    );

    _logger.logResponse(
      body: response.body,
      headers: response.headers,
      statusCode: response.statusCode,
    );

    return response;
  }

  Future<http.Response> post(NetworkRequest request) async {
    final requestHeaders = _secure(
      headers: request.headers ?? {},
      token: (await _secureStorage.getJwt())?.token,
    );

    _logger.logRequest(
      body: request.body,
      headers: requestHeaders,
      method: 'POST',
      uri: request.uri,
    );

    final response = await http.post(
      request.uri,
      body: request.body,
      headers: requestHeaders,
    );

    _logger.logResponse(
      body: response.body,
      headers: response.headers,
      statusCode: response.statusCode,
    );

    return response;
  }

  Map<String, String> _secure({
    required Map<String, String> headers,
    required String? token,
  }) {
    if (token?.isNotEmpty == true) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    return headers;
  }
}
