import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'save_client_use_case_test.mocks.dart';

@GenerateMocks([ClientRepository])
void main() {
  final now = DateTime.now();

  late Client client;
  late SaveClientUseCase useCase;
  late MockClientRepository repository;

  setUp(() {
    repository = MockClientRepository();
    useCase = SaveClientUseCase(clientRepository: repository);

    client = Client(
      address: 'address',
      caption: '',
      createdAt: now,
      deleted: 0,
      email: 'john@doe.com',
      firstName: 'John',
      id: 1,
      lastName: 'Doe',
      photo: '',
      updatedAt: now,
    );
  });

  test('Should return a Client with the same data that was sent', () async {
    // Arrange
    when(repository.saveClient(client)).thenAnswer(
      (_) async => client,
    );

    // Act
    final result = await useCase.execute(arguments: {
      SaveClientUseCaseAttributesKeys.client: client,
    });

    // Assert
    expect(result, Right(client));
  });
}
