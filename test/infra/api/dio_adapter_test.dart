import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architeture_flutter/app/data/api/http_error.dart';
import 'package:clean_architeture_flutter/app/infra/api/dio_adapter.dart';

import 'dio_adapter_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late DioAdapter sut;
  late MockDio client;
  late String url;

  setUp(
    () {
      client = MockDio();
      sut = DioAdapter(client);
      url = faker.internet.httpUrl();
    },
  );

  group('post', () {
    PostExpectation mockRequest() => when(
          client.post(
            any,
            data: anyNamed('data'),
          ),
        );

    void mockResponse(
      int statusCode, {
      Map<String, dynamic>? body,
    }) {
      body = body ?? {'any_key': 'any_value'};

      mockRequest().thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: body,
          statusCode: statusCode,
          requestOptions: RequestOptions(path: 'test'),
        ),
      );
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      final data = {'any_key': 'any_value'};

      await sut.post(
        url,
        data: data,
      );

      verify(
        client.post(
          url,
          data: anyNamed('data'),
          queryParameters: null,
          options: null,
          cancelToken: null,
          onSendProgress: null,
          onReceiveProgress: null,
        ),
      );
    });

    test('Should call post without body', () async {
      await sut.post(url, data: {});

      verify(client.post(
        url,
        data: anyNamed('data'),
        queryParameters: null,
        options: null,
        cancelToken: null,
        onSendProgress: null,
        onReceiveProgress: null,
      ));
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.post(url, data: {});

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 200 with no data', () async {
      mockResponse(HttpStatus.ok, body: {});

      final response = await sut.post(url, data: {});

      expect(response, null);
    });

    test('Should return null if post returns 204', () async {
      mockResponse(HttpStatus.noContent, body: {});

      final response = await sut.post(url, data: {});

      expect(response, null);
    });

    test('Should return null if post returns 204 with data', () async {
      mockResponse(204);

      final response = await sut.post(url, data: {});

      expect(response, null);
    });

    test('Should return BadRequestError if post returns 400', () async {
      mockResponse(HttpStatus.badRequest, body: {});

      final future = sut.post(url, data: {});

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if post returns 400', () async {
      mockResponse(HttpStatus.badRequest);

      final future = sut.post(url, data: {});

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return UnauthorizedError if post returns 401', () async {
      mockResponse(HttpStatus.unauthorized);

      final future = sut.post(url, data: {});

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return ForbiddenError if post returns 403', () async {
      mockResponse(HttpStatus.forbidden);

      final future = sut.post(url, data: {});

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if post returns 404', () async {
      mockResponse(HttpStatus.notFound);

      final future = sut.post(url, data: {});

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return ServerError if post returns 500', () async {
      mockResponse(HttpStatus.internalServerError);

      final future = sut.post(url, data: {});

      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('get', () {
    PostExpectation mockRequest() => when(client.get(any));

    void mockResponse(
      int statusCode, {
      Map<String, dynamic>? body,
    }) {
      body = body ?? {'any_key': 'any_value'};

      mockRequest().thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: body,
          statusCode: statusCode,
          requestOptions: RequestOptions(path: 'test'),
        ),
      );
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call get with correct values', () async {
      await sut.get(url);
      verify(client.get(url));

      await sut.get(url);
      verify(client.get(url));
    });

    test('Should return data if get returns 200', () async {
      final response = await sut.get(url);

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if get returns 200 with no data', () async {
      mockResponse(HttpStatus.ok, body: {});

      final response = await sut.get(url);

      expect(response, null);
    });

    test('Should return null if get returns 204', () async {
      mockResponse(HttpStatus.noContent, body: {});

      final response = await sut.get(url);

      expect(response, null);
    });

    test('Should return null if get returns 204 with data', () async {
      mockResponse(HttpStatus.noContent);

      final response = await sut.get(url);

      expect(response, null);
    });

    test('Should return BadRequestError if get returns 400', () async {
      mockResponse(HttpStatus.badRequest, body: {});

      final future = sut.get(url);

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if get returns 400', () async {
      mockResponse(HttpStatus.badRequest);

      final future = sut.get(url);

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return UnauthorizedError if get returns 401', () async {
      mockResponse(HttpStatus.unauthorized);

      final future = sut.get(url);

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return ForbiddenError if get returns 403', () async {
      mockResponse(HttpStatus.forbidden);

      final future = sut.get(url);

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if get returns 404', () async {
      mockResponse(HttpStatus.notFound);

      final future = sut.get(url);

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return ServerError if get returns 500', () async {
      mockResponse(HttpStatus.internalServerError);

      final future = sut.get(url);

      expect(future, throwsA(HttpError.serverError));
    });
  });
}
