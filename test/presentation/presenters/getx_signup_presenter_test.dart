import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architeture_flutter/app/domain/entities/user_entity.dart';
import 'package:clean_architeture_flutter/app/domain/helpers/domain_errors.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/add_user.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/save_current_user.dart';
import 'package:clean_architeture_flutter/app/presentation/presenters/getx_signup_presenter.dart';
import 'package:clean_architeture_flutter/app/presentation/protocols/validation.dart';
import 'package:clean_architeture_flutter/app/ui/helpers/ui_error.dart';

import '../../mocks/fake_user_factory.dart';
import 'getx_signup_presenter_test.mocks.dart';

@GenerateMocks([Validation, SaveCurrentUser, AddUser])
void main() {
  late GetxSignUpPresenter sut;
  late MockValidation validation;
  late MockSaveCurrentUser saveCurrentUser;
  late MockAddUser addUser;
  late String email;
  late String name;
  late String password;
  late String passwordConfirmation;
  late UserEntity user;

  PostExpectation mockValidationCall(String? field) => when(
        validation.validate(
          field: field == null ? anyNamed('field') : field,
          input: anyNamed('input'),
        ),
      );

  void mockValidation({String? field, ValidationError? value}) =>
      mockValidationCall(field).thenReturn(value);

  PostExpectation mockAddUserCall() => when(addUser.add(any));

  void mockAddUser(UserEntity data) {
    user = data;
    mockAddUserCall().thenAnswer((_) async => data);
  }

  void mockAddUserError(DomainError error) =>
      mockAddUserCall().thenThrow(error);

  PostExpectation mockSaveCurrentUserCall() => when(
        saveCurrentUser.save(any),
      );

  void mockSaveCurrentUserError() => mockSaveCurrentUserCall().thenThrow(
        DomainError.unexpected,
      );

  setUp(() {
    validation = MockValidation();
    addUser = MockAddUser();
    saveCurrentUser = MockSaveCurrentUser();
    sut = GetxSignUpPresenter(
      validation: validation,
      addUser: addUser,
      saveCurrentUser: saveCurrentUser,
    );

    email = faker.internet.email();
    password = faker.internet.password();
    passwordConfirmation = faker.internet.password();
    name = faker.person.name();
    mockValidation();
    mockAddUser(FakeUserFactory.makeEntity());
  });

  test('Should call Validation with correct email', () {
    final formData = {
      'name': '',
      'email': email,
      'password': '',
      'passwordConfirmation': ''
    };

    sut.validateEmail(email);

    verify(validation.validate(field: 'email', input: formData)).called(1);
  });

  test('Should emit invalidFieldError if email is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.emailErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.invalidField,
        ),
      ),
    );

    sut.isFormValidStream.listen(
      expectAsync1((isValid) => expect(isValid, false)),
    );

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit requiredFieldError if email is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.emailErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.requiredField,
        ),
      ),
    );
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

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
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call Validation with correct name', () {
    final formData = {
      'name': name,
      'email': '',
      'password': '',
      'passwordConfirmation': ''
    };

    sut.validateName(name);

    verify(validation.validate(field: 'name', input: formData)).called(1);
  });

  test('Should emit invalidFieldError if name is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.nameErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.invalidField,
        ),
      ),
    );
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit requiredFieldError if name is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.nameErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.requiredField,
        ),
      ),
    );
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit null if validation succeeds', () {
    sut.nameErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.nothing,
        ),
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

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should call Validation with correct password', () {
    final formData = {
      'name': '',
      'email': '',
      'password': password,
      'passwordConfirmation': ''
    };

    sut.validatePassword(password);

    verify(
      validation.validate(
        field: 'password',
        input: formData,
      ),
    ).called(1);
  });

  test('Should emit invalidFieldError if password is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.passwordErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.invalidField,
        ),
      ),
    );
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit requiredFieldError if password is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.passwordErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.requiredField,
        ),
      ),
    );
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit null if validation succeeds', () {
    sut.passwordErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.nothing,
        ),
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

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should call Validation with correct passwordConfirmation', () {
    final formData = {
      'name': '',
      'email': '',
      'password': '',
      'passwordConfirmation': passwordConfirmation
    };

    sut.validatePasswordConfirmation(passwordConfirmation);

    verify(
      validation.validate(field: 'passwordConfirmation', input: formData),
    ).called(1);
  });

  test('Should emit invalidFieldError if passwordConfirmation is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.passwordConfirmationErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.invalidField,
        ),
      ),
    );
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should emit requiredFieldError if passwordConfirmation is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.passwordConfirmationErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.requiredField,
        ),
      ),
    );
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should emit null if validation succeeds', () {
    sut.passwordConfirmationErrorStream.listen(
      expectAsync1(
        (error) => expect(
          error,
          UIError.nothing,
        ),
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

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should enable form button if all fields are valid', () async {
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateName(name);
    await Future.delayed(Duration.zero);
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
    await Future.delayed(Duration.zero);
    sut.validatePasswordConfirmation(passwordConfirmation);
    await Future.delayed(Duration.zero);
  });

  test('Should call AddUser with correct values', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    await sut.signUp();

    verify(
      addUser.add(
        AddUserParams(
          name: name,
          email: email,
          password: password,
          passwordConfirmation: passwordConfirmation,
        ),
      ),
    ).called(1);
  });

  test('Should call SaveCurrentUser with correct value', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    await sut.signUp();

    verify(saveCurrentUser.save(user)).called(1);
  });

  test('Should emit UnexpectedError if SaveCurrentUser fails', () async {
    mockSaveCurrentUserError();
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(
      sut.mainErrorStream,
      emitsInOrder(
        [
          UIError.nothing,
          UIError.unexpected,
        ],
      ),
    );

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.signUp();
  });

  test('Should emit correct events on AddUser success', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(sut.mainErrorStream, emits(UIError.nothing));
    expectLater(sut.isLoadingStream, emits(true));

    await sut.signUp();
  });

  test('Should emit correct events on EmailInUseError', () async {
    mockAddUserError(DomainError.emailInUse);
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(
      sut.mainErrorStream,
      emitsInOrder(
        [
          UIError.nothing,
          UIError.emailInUse,
        ],
      ),
    );

    await sut.signUp();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAddUserError(DomainError.unexpected);
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(
      sut.mainErrorStream,
      emitsInOrder(
        [
          UIError.nothing,
          UIError.unexpected,
        ],
      ),
    );

    await sut.signUp();
  });

  test('Should change page on success', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    sut.navigateToStream.listen(
      expectAsync1(
        (page) => expect(
          page,
          '/surveys',
        ),
      ),
    );

    await sut.signUp();
  });

  test('Should go to LoginPage on link click', () async {
    sut.navigateToStream.listen(
      expectAsync1(
        (page) => expect(page, '/login'),
      ),
    );

    sut.goToLogin();
  });
}
