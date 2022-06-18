import 'package:domain/domain.dart';

abstract class ClientRepository {
  Future<bool> deleteClient(int clientId);

  Future<ClientList> listClients({int? page});

  Future<Client> saveClient(Client client);
}
