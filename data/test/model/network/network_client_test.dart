import 'dart:convert';

import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should be able to parse a client', () {
    // Arrange
    final rawData =
        '{"id":920,"firstname":"Roy","lastname":"White","email":"matias@agencycoda.com","address":"Buenos Aires, Argentina","photo":"","caption":"","created_at":"2022-06-17T22:24:06.000000Z","updated_at":"2022-06-17T22:24:06.000000Z","deleted":0}';

    // Act
    final client = NetworkClient.fromDynamic(
      json.decode(rawData),
    );

    // Assert
    expect(client.firstName, 'Roy');
    expect(client.lastName, 'White');
    expect(client.email, 'matias@agencycoda.com');
  });
}
