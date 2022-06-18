import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:json_class/json_class.dart';

class NetworkUser extends User {
  NetworkUser({
    super.accessToken,
    super.caption,
    required super.createdAt,
    required super.email,
    super.facebookId,
    required super.firstName,
    required super.id,
    super.isNotification,
    required super.lastName,
    required super.phone,
    required super.photo,
    required super.role,
    super.status,
    super.tokenType,
    required super.updatedAt,
  });

  factory NetworkUser.fromDynamic(dynamic map) => NetworkUser(
        accessToken: NetworkJwt.fromToken(map[_AttributesKeys.accessToken]),
        caption: map[_AttributesKeys.caption],
        createdAt: JsonClass.parseDateTime(map[_AttributesKeys.createdAt])!,
        email: map[_AttributesKeys.email],
        facebookId: JsonClass.parseInt(map[_AttributesKeys.facebookId]),
        firstName: map[_AttributesKeys.firstName],
        id: JsonClass.parseInt(map[_AttributesKeys.id])!,
        isNotification: JsonClass.parseInt(
          map[_AttributesKeys.isNotification],
        ),
        lastName: map[_AttributesKeys.lastName],
        phone: map[_AttributesKeys.phone],
        photo: map[_AttributesKeys.photo],
        role: JsonClass.parseInt(map[_AttributesKeys.role])!,
        status: JsonClass.parseInt(map[_AttributesKeys.status]),
        tokenType: map[_AttributesKeys.tokenType],
        updatedAt: JsonClass.parseDateTime(map[_AttributesKeys.updatedAt])!,
      );
}

class _AttributesKeys {
  static const String accessToken = 'access_token';
  static const String caption = 'caption';
  static const String createdAt = 'created_at';
  static const String email = 'email';
  static const String facebookId = 'facebook_id';
  static const String firstName = 'firstname';
  static const String id = 'id';
  static const String isNotification = 'is_notification';
  static const String lastName = 'lastname';
  static const String phone = 'phone';
  static const String photo = 'photo';
  static const String role = 'role';
  static const String status = 'status';
  static const String tokenType = 'token_type';
  static const String updatedAt = 'updated_at';
}
