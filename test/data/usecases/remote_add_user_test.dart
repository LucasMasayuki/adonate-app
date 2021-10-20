import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architeture_flutter/app/data/api/graphql.dart';
import 'package:clean_architeture_flutter/app/data/api/http_error.dart';
import 'package:clean_architeture_flutter/app/data/usecases/remote_add_user_.dart';
import 'package:clean_architeture_flutter/app/domain/helpers/domain_errors.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/add_user.dart';
import 'package:clean_architeture_flutter/app/main/graphql/auth.dart';

import '../../mocks/fake_params_factory.dart';
import '../../mocks/fake_user_factory.dart';

import 'remote_add_user_test.mocks.dart';

@GenerateMocks(
  [GraphQl],
)
void main() {
  late RemoteAddUser sut;
  late MockGraphQl graphQLClient;
  late AddUserParams params;
  late Map apiResult;

  PostExpectation mockRequest() => when(
        graphQLClient.mutate(any, any),
      );

  void mockHttpData(Map<String, dynamic> data) {
    apiResult = data;
    mockRequest().thenAnswer(
      (_) async => data,
    );
  }

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    graphQLClient = MockGraphQl();
    sut = RemoteAddUser(graphQlClient: graphQLClient);
    params = FakeParamsFactory.makeAddUser();
    mockHttpData(FakeUserFactory.makeApiJson());
  });

  test('Should call GraphQlClient with correct values', () async {
    await sut.add(params);

    final data = {
      'name': params.name,
      'email': params.email,
      'password': params.password,
      'passwordConfirmation': params.passwordConfirmation
    };

    verify(
      graphQLClient.mutate(SIGNUP_MUTATION, data),
    );
  });

  test('Should throw UnexpectedError if GraphQlClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if GraphQlClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if GraphQlClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if GraphQlClient returns 403',
      () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.emailInUse));
  });

  test('Should return an Account if GraphQlClient returns 200', () async {
    final account = await sut.add(params);

    expect(account.token, apiResult['token']);
  });

  test(
      'Should throw UnexpectedError if GraphQlClient returns 200 with invalid data',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
