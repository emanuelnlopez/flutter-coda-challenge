import 'dart:convert';

import 'package:data/data.dart';

class ClientListRequest extends NetworkRequest {
  ClientListRequest({
    required int pageNumber,
    required String url,
  }) : super(
          url: url.replaceAll(
            '{pageNumber}',
            pageNumber.toString(),
          ),
        );

  @override
  String? get body => json.encode({});

  @override
  Map<String, String>? get headers => null;
}
