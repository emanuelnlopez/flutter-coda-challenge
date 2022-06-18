class Client {
  Client({
    required this.address,
    required this.caption,
    this.createdAt,
    this.deleted,
    required this.email,
    required this.firstName,
    this.id,
    required this.lastName,
    required this.photo,
    this.updatedAt,
  });

  final String address;
  final String caption;
  final DateTime? createdAt;
  final int? deleted;
  final String email;
  final String firstName;
  final int? id;
  final String lastName;
  final String photo;
  final DateTime? updatedAt;

  String get fullName => '$firstName $lastName';
}
