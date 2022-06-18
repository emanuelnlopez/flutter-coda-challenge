import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:json_class/json_class.dart';

class NetworkClientList extends ClientList {
  NetworkClientList({
    required super.currentPage,
    required super.data,
    required super.lastPage,
  });

  factory NetworkClientList.fromDynamic(dynamic map) => NetworkClientList(
        currentPage: JsonClass.parseInt(
          map[_AttributesKeys.currentPage],
        )!,
        data: NetworkClient.fromDynamicList(
          map[_AttributesKeys.data],
        ),
        lastPage: JsonClass.parseInt(
          map[_AttributesKeys.lastPage],
        )!,
      );
}

class _AttributesKeys {
  static const String currentPage = 'current_page';
  static const String data = 'data';
  static const String lastPage = 'last_page';
}
