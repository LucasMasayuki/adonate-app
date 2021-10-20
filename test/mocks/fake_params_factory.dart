import 'package:faker/faker.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/add_user.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/authentication.dart';

class FakeParamsFactory {
  static AuthenticationParams makeAuthentication() => AuthenticationParams(
        email: faker.internet.email(),
        password: faker.internet.password(),
      );

  static AddUserParams makeAddUser() => AddUserParams(
        name: faker.person.name(),
        email: faker.internet.email(),
        password: faker.internet.password(),
        passwordConfirmation: faker.internet.password(),
      );
}
