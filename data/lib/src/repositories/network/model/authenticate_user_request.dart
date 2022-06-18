import 'dart:convert';
import 'dart:io';

import 'package:data/data.dart';

class AuthenticateUserRequest extends NetworkRequest {
  AuthenticateUserRequest({
    required this.email,
    required this.password,
    required String url,
  }) : super(url: url);

  final String email;
  final String password;

  @override
  String? get body => json.encode(
        {
          _AttributesKeys.email: email,
          _AttributesKeys.password: password,
        },
      );

  @override
  Map<String, String>? get headers => {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.acceptHeader: ContentType.json.toString(),
      };
}

class _AttributesKeys {
  static const String email = 'email';
  static const String password = 'password';
}
