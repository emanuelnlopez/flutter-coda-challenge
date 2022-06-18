import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  test('Should be able to access all client data', () {
    final aDate = DateTime.now();

    final client = Client(
      address: 'Avenida Siempre Viva 1234',
      caption: '',
      createdAt: aDate,
      deleted: 0,
      email: 'client@agencycoda.com',
      firstName: 'Juan José',
      id: 1,
      lastName: 'Coda',
      photo: '',
      updatedAt: aDate,
    );

    expect(client.address, 'Avenida Siempre Viva 1234');
    expect(client.caption, '');
    expect(client.createdAt, aDate);
    expect(client.deleted, 0);
    expect(client.email, 'client@agencycoda.com');
    expect(client.firstName, 'Juan José');
    expect(client.id, 1);
    expect(client.lastName, 'Coda');
    expect(client.photo, '');
    expect(client.updatedAt, aDate);
  });
}
