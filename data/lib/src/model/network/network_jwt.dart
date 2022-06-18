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
        payload['exp'] * 1000,
      );

      final issuedAt = DateTime.fromMillisecondsSinceEpoch(
        payload['iat'] * 1000,
      );

      result = NetworkJwt(
        expiresAt: expiresAt,
        issuedAt: issuedAt,
        token: token,
        userId: JsonClass.parseInt(payload['data']['id']),
        userEmail: payload['data']['email'],
      );
    }
    return result;
  }
}
