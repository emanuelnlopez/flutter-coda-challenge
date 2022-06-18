import 'package:data/data.dart';

class DeleteClientRequest extends NetworkRequest {
  DeleteClientRequest({
    required int clientId,
    required String url,
  }) : super(
            url: url.replaceAll(
          '{clientId}',
          clientId.toString(),
        ));

  @override
  String? get body => null;

  @override
  Map<String, String>? get headers => null;
}
