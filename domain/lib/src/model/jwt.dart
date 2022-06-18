class Jwt {
  Jwt({
    required this.expiresAt,
    this.issuedAt,
    required this.token,
    this.userId,
    this.userEmail,
  });

  final DateTime? expiresAt;
  final DateTime? issuedAt;
  final String? token;
  final int? userId;
  final String? userEmail;

  bool get valid =>
      expiresAt != null &&
      token?.isNotEmpty == true &&
      expiresAt!.compareTo(DateTime.now()) > 0;
}
