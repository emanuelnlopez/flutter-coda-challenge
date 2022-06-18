import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should be able to parse an accessToken a view its details', () {
    ///
    ///{
    /// "iss": "https://agencycoda.com",
    /// "aud": "https://agencycoda.com",
    /// "iat": 1655509394,
    /// "nbf": 1655509394,
    /// "exp": 1656805394,
    /// "uid": 1,
    /// "data": {
    ///   "id": 1,
    /// "email": "test@coda.com"
    /// }
    ///}
    ///

    // Arrange
    final accessToken =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYWdlbmN5Y29kYS5jb20iLCJhdWQiOiJodHRwczpcL1wvYWdlbmN5Y29kYS5jb20iLCJpYXQiOjE2NTU1MDkzOTQsIm5iZiI6MTY1NTUwOTM5NCwiZXhwIjoxNjU2ODA1Mzk0LCJ1aWQiOjEsImRhdGEiOnsiaWQiOjEsImVtYWlsIjoidGVzdEBjb2RhLmNvbSJ9fQ.aCQP48Bd1HDORPh2cokHumSVolIcUVqdMhpCiBmAUHM';

    // Act
    final jwt = NetworkJwt.fromToken(accessToken);

    // Assert
    expect(jwt!.userEmail, 'test@coda.com');
    expect(jwt.userId, 1);

    expect(
      jwt.expiresAt,
      DateTime.fromMillisecondsSinceEpoch(
        1656805394 * 1000,
      ),
    );

    expect(
      jwt.issuedAt,
      DateTime.fromMillisecondsSinceEpoch(
        1655509394 * 1000,
      ),
    );
  });
}
