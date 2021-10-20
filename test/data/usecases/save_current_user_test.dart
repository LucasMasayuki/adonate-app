import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architeture_flutter/app/data/cache/save_shared_preferences.dart';
import 'package:clean_architeture_flutter/app/data/usecases/save_current_user.dart';
import 'package:clean_architeture_flutter/app/domain/entities/user_entity.dart';
import 'package:clean_architeture_flutter/app/domain/helpers/domain_errors.dart';

import 'save_current_user_test.mocks.dart';

@GenerateMocks([SaveSharedPreferences])
void main() {
  late LocalSaveCurrentUser sut;
  late MockSaveSharedPreferences saveSharedPreferences;
  late UserEntity user;

  void mockError() => when(
        saveSharedPreferences.save(
          key: anyNamed('key'),
          value: anyNamed('value'),
        ),
      ).thenThrow(Exception());

  setUp(() {
    saveSharedPreferences = MockSaveSharedPreferences();
    sut = LocalSaveCurrentUser(
      saveSharedPreferences: saveSharedPreferences,
    );

    user = UserEntity(token: faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(user);

    verify(saveSharedPreferences.save(key: 'token', value: user.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws',
      () async {
    mockError();

    final future = sut.save(user);

    expect(future, throwsA(DomainError.unexpected));
  });
}
