import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  test('Should be able to access all user data', () {
    final aDate = DateTime.now();

    final user = User(
      accessToken: Jwt(
        expiresAt: DateTime.now(),
        token: 'token',
      ),
      createdAt: aDate,
      email: 'emanuel.n.lopez@gmail.com',
      firstName: 'Emanuel',
      id: 1,
      isNotification: 0,
      lastName: 'López',
      phone: '+542914407458',
      photo: '',
      role: 0,
      status: 0,
      tokenType: 'bearer',
      updatedAt: aDate,
    );

    expect(user.accessToken, 'jwt');
    expect(user.createdAt, aDate);
    expect(user.email, 'emanuel.n.lopez@gmail.com');
    expect(user.firstName, 'Emanuel');
    expect(user.id, 1);
    expect(user.isNotification, 0);
    expect(user.lastName, 'López');
    expect(user.phone, '+542914407458');
    expect(user.photo, '');
    expect(user.role, 0);
    expect(user.status, 0);
    expect(user.tokenType, 'bearer');
    expect(user.updatedAt, aDate);
  });
}
