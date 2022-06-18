abstract class NetworkRequest {
  NetworkRequest({required this.url});

  final String url;

  String? get body;

  Map<String, String>? get headers;

  Uri get uri => Uri.parse(url);
}
