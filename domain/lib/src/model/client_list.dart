import 'package:domain/domain.dart';

class ClientList {
  ClientList({
    required this.currentPage,
    required this.data,
    required this.lastPage,
  });

  final int currentPage;
  final List<Client> data;
  final int lastPage;
}
