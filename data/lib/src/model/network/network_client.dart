import 'package:domain/domain.dart';
import 'package:json_class/json_class.dart';

class NetworkClient extends Client {
  NetworkClient({
    required super.address,
    required super.caption,
    super.createdAt,
    super.deleted,
    required super.email,
    required super.firstName,
    super.id,
    required super.lastName,
    required super.photo,
    super.updatedAt,
  });

  factory NetworkClient.fromDynamic(dynamic map) => NetworkClient(
        address: map[_AttributesKeys.address],
        caption: map[_AttributesKeys.caption],
        createdAt: JsonClass.parseDateTime(map[_AttributesKeys.createdAt])!,
        deleted: JsonClass.parseInt(map[_AttributesKeys.deleted]),
        email: map[_AttributesKeys.email],
        firstName: map[_AttributesKeys.firstName],
        id: JsonClass.parseInt(map[_AttributesKeys.id])!,
        lastName: map[_AttributesKeys.lastName],
        photo: map[_AttributesKeys.photo],
        updatedAt: JsonClass.parseDateTime(map[_AttributesKeys.updatedAt])!,
      );

  static List<NetworkClient> fromDynamicList(dynamic list) {
    final result = <NetworkClient>[];

    if (list != null) {
      for (dynamic map in list) {
        result.add(NetworkClient.fromDynamic(map));
      }
    }

    return result;
  }
}

class _AttributesKeys {
  static const String address = 'address';
  static const String caption = 'caption';
  static const String createdAt = 'created_at';
  static const String deleted = 'deleted';
  static const String email = 'email';
  static const String firstName = 'firstname';
  static const String id = 'id';
  static const String lastName = 'lastname';
  static const String photo = 'photo';
  static const String updatedAt = 'updated_at';
}
