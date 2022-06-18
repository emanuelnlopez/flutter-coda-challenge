import 'dart:convert';

import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should be able to parse a client', () {
    // Arrange
    final rawData =
        '{"id":1,"firstname":"empty","lastname":"","email":"test@coda.com","photo":"","phone":"","facebook_id":null,"role":0,"created_at":"2022-06-10T23:18:20.000000Z","updated_at":"2022-06-10T23:18:20.000000Z","status":0,"is_notification":0,"caption":null,"token_type":"bearer","access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYWdlbmN5Y29kYS5jb20iLCJhdWQiOiJodHRwczpcL1wvYWdlbmN5Y29kYS5jb20iLCJpYXQiOjE2NTU1MDkzOTQsIm5iZiI6MTY1NTUwOTM5NCwiZXhwIjoxNjU2ODA1Mzk0LCJ1aWQiOjEsImRhdGEiOnsiaWQiOjEsImVtYWlsIjoidGVzdEBjb2RhLmNvbSJ9fQ.aCQP48Bd1HDORPh2cokHumSVolIcUVqdMhpCiBmAUHM"}';

    // Act
    final user = NetworkUser.fromDynamic(
      json.decode(rawData),
    );

    // Assert
    expect(user.firstName, 'empty');
    expect(user.lastName, isEmpty);
    expect(user.phone, isEmpty);
    expect(user.photo, isEmpty);
    expect(user.email, 'test@coda.com');
    expect(user.role, 0);
    expect(user.status, 0);
  });
}
