import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architeture_flutter/app/domain/entities/user_entity.dart';
import 'package:clean_architeture_flutter/app/domain/helpers/domain_errors.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/authentication.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/save_current_user.dart';
import 'package:clean_architeture_flutter/app/presentation/presenters/getx_login_presenter.dart';
import 'package:clean_architeture_flutter/app/presentation/protocols/validation.dart';
import 'package:clean_architeture_flutter/app/ui/helpers/ui_error.dart';

import '../../mocks/fake_user_factory.dart';
import 'getx_login_presenter_test.mocks.dart';

@GenerateMocks([Authentication, Validation, SaveCurrentUser])
void main() {
  late GetxLoginPresenter sut;
  late MockAuthentication authentication;
  late MockValidation validation;
  late MockSaveCurrentUser saveCurrentUser;
  late String email;
  late String password;
  late UserEntity user;

  PostExpectation mockValidationCall(String? field) => when(
        validation.validate(
          field: field == null ? anyNamed('field') : field,
          input: anyNamed('input'),
        ),
      );

  void mockValidation({String? field, ValidationError? value}) =>
      mockValidationCall(field).thenReturn(value);

  PostExpectation mockAuthenticationCall() => when(
        authentication.auth(any),
      );

  void mockAuthentication(UserEntity data) {
    user = data;
    mockAuthenticationCall().thenAnswer((_) async => data);
  }

  void mockAuthenticationError(DomainError error) =>
      mockAuthenticationCall().thenThrow(error);

  PostExpectation mockSaveCurrentAccountCall() =>
      when(saveCurrentUser.save(any));

  void mockSaveCurrentAccountError() =>
      mockSaveCurrentAccountCall().thenThrow(DomainError.unexpected);

  setUp(() {
    validation = MockValidation();
    authentication = MockAuthentication();
    saveCurrentUser = MockSaveCurrentUser();

    sut = GetxLoginPresenter(
      validation: validation,
      authentication: authentication,
      saveCurrentUser: saveCurrentUser,
    );

    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
    mockAuthentication(FakeUserFactory.makeEntity());
  });

  test('Should call Validation with correct email', () {
    final formData = {'email': email, 'password': ''};

    sut.validateEmail(email);

    verify(
      validation.validate(field: 'email', input: formData),
    ).called(1);
  });

  test('Should emit invalidFieldError if email is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.emailErrorStream.listen(
      expectAsync1(
        (error) => expect(error, UIError.invalidField),
      ),
    );
    sut.isFormValidStream.listen(
      expectAsync1(
        (isValid) => expect(
          isValid,
          false,
        ),
      ),
    );

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit requiredFieldError if email is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.emailErrorStream.listen(
      expectAsync1(
        (error) => expect(error, UIError.requiredField),
      ),
    );

    sut.isFormValidStream.listen(
      expectAsync1(
        (isValid) => expect(isValid, false),
      ),
    );

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validation succeeds', () {
    sut.emailErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.nothing,
        ),
      ),
    );

    sut.isFormValidStream.listen(
      expectAsync1(
        (isValid) => expect(isValid, false),
      ),
    );

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call Validation with correct password', () {
    final formData = {'email': '', 'password': password};

    sut.validatePassword(password);

    verify(
      validation.validate(field: 'password', input: formData),
    ).called(1);
  });

  test('Should emit requiredFieldError if password is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.passwordErrorStream.listen(
      expectAsync1(
        (error) => expect(error, UIError.requiredField),
      ),
    );

    sut.isFormValidStream.listen(
      expectAsync1(
        (isValid) => expect(isValid, false),
      ),
    );

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit nothing if validation succeeds', () {
    sut.passwordErrorStream.listen(
      expectAsync1(
        (error) => expect(error, UIError.nothing),
      ),
    );

    sut.isFormValidStream.listen(
      expectAsync1(
        (isValid) => expect(isValid, false),
      ),
    );

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should disable form button if any field is invalid', () {
    mockValidation(
      field: 'email',
      value: ValidationError.invalidField,
    );

    sut.isFormValidStream.listen(
      expectAsync1(
        (isValid) => expect(isValid, false),
      ),
    );

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should enable form button if all fields are valid', () async {
    expectLater(
      sut.isFormValidStream,
      emitsInOrder([false, true]),
    );

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call Authentication with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(
      authentication.auth(
        AuthenticationParams(email: email, password: password),
      ),
    ).called(1);
  });

  test('Should call SaveCurrentAccount with correct value', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(saveCurrentUser.save(user)).called(1);
  });

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
    mockSaveCurrentAccountError();
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(
      sut.isLoadingStream,
      emitsInOrder([true, false]),
    );

    expectLater(
      sut.mainErrorStream,
      emitsInOrder(
        [UIError.nothing, UIError.unexpected],
      ),
    );

    await sut.auth();
  });

  test('Should emit correct events on Authentication success', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.mainErrorStream, emits(UIError.nothing));
    expectLater(sut.isLoadingStream, emits(true));

    await sut.auth();
  });

  test('Should change page on success', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.auth();
  });

  test('Should emit correct events on InvalidCredentialsError', () async {
    mockAuthenticationError(DomainError.invalidCredentials);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(
      sut.isLoadingStream,
      emitsInOrder([true, false]),
    );

    expectLater(
      sut.mainErrorStream,
      emitsInOrder(
        [UIError.nothing, UIError.invalidCredentials],
      ),
    );

    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAuthenticationError(DomainError.unexpected);
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(
      sut.isLoadingStream,
      emitsInOrder([true, false]),
    );

    expectLater(
      sut.mainErrorStream,
      emitsInOrder(
        [UIError.nothing, UIError.unexpected],
      ),
    );

    await sut.auth();
  });

  test('Should go to SignUpPage on link click', () async {
    sut.navigateToStream.listen(
      expectAsync1(
        (page) => expect(page, '/signup'),
      ),
    );

    sut.goToSignUp();
  });
}
