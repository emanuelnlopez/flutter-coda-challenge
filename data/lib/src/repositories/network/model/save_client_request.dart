import 'dart:convert';
import 'dart:io';

import 'package:data/data.dart';
import 'package:domain/domain.dart';

class SaveClientRequest extends NetworkRequest {
  SaveClientRequest({
    required this.client,
    required super.url,
  });

  final Client client;

  @override
  String? get body {
    final data = {
      _AttributesKeys.address: client.address,
      _AttributesKeys.caption: client.caption,
      _AttributesKeys.email: client.email,
      _AttributesKeys.firstName: client.firstName,
      _AttributesKeys.id: client.id,
      _AttributesKeys.lastName: client.lastName,
      _AttributesKeys.photo: client.photo,
    };

    data.removeWhere((key, value) => value == null);

    return json.encode(data);
  }

  @override
  Map<String, String>? get headers => {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.acceptHeader: ContentType.json.toString(),
      };
}

class _AttributesKeys {
  static const String address = 'address';
  static const String caption = 'caption';
  static const String email = 'email';
  static const String firstName = 'firstname';
  static const String id = 'id';
  static const String lastName = 'lastname';
  static const String photo = 'photo';
}
