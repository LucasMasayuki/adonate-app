import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architeture_flutter/app/data/api/http_error.dart';
import 'package:clean_architeture_flutter/app/infra/api/graphql_adapter.dart';
import 'package:clean_architeture_flutter/app/main/graphql/auth.dart';

import "package:http/http.dart" as http;

import 'graphql_adapter_test.mocks.dart';

@GenerateMocks([GraphQLClient])
void main() {
  late GraphQlAdapter sut;
  late MockGraphQLClient client;

  setUp(
    () {
      client = MockGraphQLClient();
      sut = GraphQlAdapter(client);
    },
  );

  group('query', () {
    PostExpectation mockQuery() => when(client.query(any));
    PostExpectation mockMutate() => when(client.mutate(any));

    void mockResponse(
      Map<String, dynamic>? data,
      OperationException? exception,
    ) {
      mockQuery().thenAnswer(
        (_) async => QueryResult(
          data: data,
          exception: exception,
          source: null,
        ),
      );

      mockMutate().thenAnswer(
        (_) async => QueryResult(
          data: data,
          exception: exception,
          source: null,
        ),
      );
    }

    void mockExceptionResponse(OperationException exception) {
      mockResponse(null, exception);
    }

    void mockSuccessResponse(Map<String, dynamic> data) {
      mockResponse(data, null);
    }

    test('When query returns not found error, should not found exception', () {
      final exception = OperationException(
        linkException: HttpLinkServerException(
          response: http.Response('', HttpStatus.notFound),
          parsedResponse: Response(),
        ),
      );

      mockExceptionResponse(exception);

      final future = sut.query(LOGIN_QUERY, {});

      expect(future, throwsA(HttpError.notFound));
    });

    test('When query returns no content error, should null', () async {
      final exception = OperationException(
        linkException: HttpLinkServerException(
          response: http.Response('', HttpStatus.noContent),
          parsedResponse: Response(),
        ),
      );

      mockExceptionResponse(exception);

      final future = await sut.query(LOGIN_QUERY, {});

      expect(future, null);
    });

    test('When query returns bad request error, should bad request exception',
        () {
      final exception = OperationException(
        linkException: HttpLinkServerException(
          response: http.Response('', HttpStatus.badRequest),
          parsedResponse: Response(),
        ),
      );

      mockExceptionResponse(exception);

      final future = sut.query(LOGIN_QUERY, {});
      expect(future, throwsA(HttpError.badRequest));
    });

    test('When query returns unauthorized error, should unauthorized exception',
        () {
      final exception = OperationException(
        linkException: HttpLinkServerException(
          response: http.Response('', HttpStatus.unauthorized),
          parsedResponse: Response(),
        ),
      );

      mockExceptionResponse(exception);

      final future = sut.query(LOGIN_QUERY, {});

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('When query returns forbidden error, should forbidden exception', () {
      final exception = OperationException(
        linkException: HttpLinkServerException(
          response: http.Response('', HttpStatus.forbidden),
          parsedResponse: Response(),
        ),
      );

      mockExceptionResponse(exception);

      final future = sut.query(LOGIN_QUERY, {});

      expect(future, throwsA(HttpError.forbidden));
    });

    test('When query returns success and data, should return response data',
        () async {
      final data = {'accessToken': 'test'};

      mockSuccessResponse(data);

      final future = await sut.query(LOGIN_QUERY, {});

      expect(future, data);
    });

    test('When mutate returns success and data, should return response data',
        () async {
      final data = {'accessToken': 'test'};

      mockSuccessResponse(data);

      final future = await sut.mutate(SIGNUP_MUTATION, {});

      expect(future, data);
    });
  });
}
