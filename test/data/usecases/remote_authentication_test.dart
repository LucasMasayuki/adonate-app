import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architeture_flutter/app/data/api/graphql.dart';
import 'package:clean_architeture_flutter/app/data/api/http_error.dart';
import 'package:clean_architeture_flutter/app/data/usecases/remote_authentication.dart';
import 'package:clean_architeture_flutter/app/domain/helpers/domain_errors.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/authentication.dart';
import 'package:clean_architeture_flutter/app/main/graphql/auth.dart';

import '../../mocks/fake_params_factory.dart';
import '../../mocks/fake_user_factory.dart';
import 'remote_authentication_test.mocks.dart';

@GenerateMocks([GraphQl])
void main() {
  late RemoteAuthentication sut;
  late MockGraphQl graphQlClient;
  late AuthenticationParams params;
  late Map apiResult;

  PostExpectation mockRequest() => when(
        graphQlClient.query(any, any),
      );

  void mockHttpData(Map<String, dynamic> data) {
    apiResult = data;
    mockRequest().thenAnswer(
      (_) async => data,
    );
  }

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    graphQlClient = MockGraphQl();
    sut = RemoteAuthentication(graphQlClient: graphQlClient);
    params = FakeParamsFactory.makeAuthentication();
    mockHttpData(FakeUserFactory.makeApiJson());
  });

  test('Should call dioClient with correct values', () async {
    await sut.auth(params);
    final data = {
      'email': params.email,
      'password': params.password,
    };

    verify(graphQlClient.query(LOGIN_QUERY, data));
  });

  test('Should throw UnexpectedError if dioClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if dioClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if dioClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if dioClient returns 401',
      () async {
    mockHttpError(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an User if dioClient returns 200', () async {
    final user = await sut.auth(params);

    expect(user.token, apiResult['token']);
  });

  test(
      'Should throw UnexpectedError if dioClient returns 200 with invalid data',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
