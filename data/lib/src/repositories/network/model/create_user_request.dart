import 'package:data/data.dart';

class CreateUserRequest extends AuthenticateUserRequest {
  CreateUserRequest({
    required super.email,
    required super.password,
    required super.url,
  });
}
