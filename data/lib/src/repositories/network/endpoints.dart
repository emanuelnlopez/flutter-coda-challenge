class Endpoints {
  static const _baseUrl = 'https://agency-coda.uc.r.appspot.com';

  static const authenticateUser = '$_baseUrl/mia-auth/login';
  static const createUser = '$_baseUrl/mia-auth/register';
  static const deleteClient = '$_baseUrl/client/remove/{clientId}';
  static const listClients = '$_baseUrl/client/list?page={pageNumber}';
  static const saveClient = '$_baseUrl/client/save';
}
