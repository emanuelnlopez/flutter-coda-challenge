import 'package:domain/domain.dart';

class User {
  User({
    this.accessToken,
    this.caption,
    required this.createdAt,
    required this.email,
    this.facebookId,
    required this.firstName,
    required this.id,
    this.isNotification,
    required this.lastName,
    required this.phone,
    required this.photo,
    required this.role,
    this.status,
    this.tokenType,
    required this.updatedAt,
  });

  final Jwt? accessToken;
  final String? caption;
  final DateTime createdAt;
  final String email;
  final int? facebookId;
  final String firstName;
  final int id;
  final int? isNotification;
  final String lastName;
  final String phone;
  final String photo;
  final int role;
  final int? status;
  final String? tokenType;
  final DateTime updatedAt;

  String get fullName => ' $firstName $lastName';
}
