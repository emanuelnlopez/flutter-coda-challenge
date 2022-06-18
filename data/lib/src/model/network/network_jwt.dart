import 'dart:convert';

import 'package:domain/domain.dart';
import 'package:json_class/json_class.dart';

class NetworkJwt extends Jwt {
  NetworkJwt({
    required super.expiresAt,
    super.issuedAt,
    required super.token,
    super.userId,
    super.userEmail,
  });

  static NetworkJwt? fromToken(String? token) {
    NetworkJwt? result;
    if (token?.isNotEmpty == true) {
      final parts = token!.split('\.');
      final payloadPart = parts[1];

      Map<String, dynamic> payload = json.decode(
        utf8.decode(
          base64Decode(
            base64.normalize(payloadPart),
          ),
        ),
      );

      final expiresAt = DateTime.fromMillisecondsSinceEpoch(
        payload[_AttributesKeys.exp] * 1000,
      );

      final issuedAt = DateTime.fromMillisecondsSinceEpoch(
        payload[_AttributesKeys.iat] * 1000,
      );

      result = NetworkJwt(
        expiresAt: expiresAt,
        issuedAt: issuedAt,
        token: token,
        userId: JsonClass.parseInt(
          payload[_AttributesKeys.data][_AttributesKeys.id],
        ),
        userEmail: payload[_AttributesKeys.data][_AttributesKeys.email],
      );
    }
    return result;
  }
}

class _AttributesKeys {
  static const String data = 'data';
  static const String email = 'email';
  static const String exp = 'exp';
  static const String iat = 'iat';
  static const String id = 'id';
}
