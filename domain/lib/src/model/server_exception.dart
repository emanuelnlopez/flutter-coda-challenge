class ServerException implements Exception {
  ServerException({
    required this.code,
    required this.message,
  });

  final int code;
  final String message;
}
