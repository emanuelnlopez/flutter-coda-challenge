import 'dart:convert';

import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should be able to parse a client list', () {
    // Arrange
    final rawData =
        '{"current_page":1,"data":[{"id":922,"firstname":"Samuel","lastname":"King","email":"matias@agencycoda.com","address":"Buenos Aires, Argentina","photo":"","caption":"","created_at":"2022-06-17T22:24:20.000000Z","updated_at":"2022-06-17T22:24:20.000000Z","deleted":0},{"id":921,"firstname":"Kimberly","lastname":"Wilson","email":"matias@agencycoda.com","address":"Buenos Aires, Argentina","photo":"","caption":"","created_at":"2022-06-17T22:24:13.000000Z","updated_at":"2022-06-17T22:24:13.000000Z","deleted":0},{"id":920,"firstname":"Roy","lastname":"White","email":"matias@agencycoda.com","address":"Buenos Aires, Argentina","photo":"","caption":"","created_at":"2022-06-17T22:24:06.000000Z","updated_at":"2022-06-17T22:24:06.000000Z","deleted":0},{"id":919,"firstname":"Virginia","lastname":"Kelly","email":"matias@agencycoda.com","address":"Buenos Aires, Argentina","photo":"","caption":"","created_at":"2022-06-17T22:23:59.000000Z","updated_at":"2022-06-17T22:23:59.000000Z","deleted":0},{"id":918,"firstname":"Frances","lastname":"Gonzales","email":"matias@agencycoda.com","address":"Buenos Aires, Argentina","photo":"","caption":"","created_at":"2022-06-17T22:23:50.000000Z","updated_at":"2022-06-17T22:23:50.000000Z","deleted":0}],"last_page":1}';

    // Act
    final clientList = NetworkClientList.fromDynamic(
      json.decode(rawData),
    );

    // Assert
    expect(clientList.data.length, 5);
    expect(clientList.currentPage, 1);
    expect(clientList.lastPage, 1);
  });
}
