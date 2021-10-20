import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architeture_flutter/app/data/cache/fetch_shared_preferences.dart';
import 'package:clean_architeture_flutter/app/data/usecases/local_load_current_user.dart';
import 'package:clean_architeture_flutter/app/domain/entities/user_entity.dart';
import 'package:clean_architeture_flutter/app/domain/helpers/domain_errors.dart';

import 'local_load_current_user_test.mocks.dart';

@GenerateMocks([FetchSharedPreferences])
void main() {
  late LocalLoadCurrentUser sut;
  late MockFetchSharedPreferences fetchSharedPreferences;
  late String token;

  PostExpectation mockFetchSecureCall() =>
      when(fetchSharedPreferences.fetch(any));

  void mockFetchSecure() =>
      mockFetchSecureCall().thenAnswer((_) async => token);

  void mockFetchSecureError() => mockFetchSecureCall().thenThrow(Exception());

  setUp(() {
    fetchSharedPreferences = MockFetchSharedPreferences();
    sut = LocalLoadCurrentUser(
      fetchSharedPreferences: fetchSharedPreferences,
    );

    token = faker.guid.guid();
    mockFetchSecure();
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(fetchSharedPreferences.fetch('token'));
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, UserEntity(token: token));
  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage throws',
      () async {
    mockFetchSecureError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
