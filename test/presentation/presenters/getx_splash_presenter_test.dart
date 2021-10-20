import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architeture_flutter/app/domain/entities/user_entity.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/load_current_user.dart';
import 'package:clean_architeture_flutter/app/presentation/presenters/getx_splash_presenter.dart';

import '../../mocks/fake_user_factory.dart';
import 'getx_splash_presenter_test.mocks.dart';

@GenerateMocks([LoadCurrentUser])
void main() {
  late GetxSplashPresenter sut;
  late MockLoadCurrentUser loadCurrentUser;

  PostExpectation mockLoadCurrentAccountCall() => when(loadCurrentUser.load());

  void mockLoadCurrentAccount({UserEntity? account}) =>
      mockLoadCurrentAccountCall().thenAnswer((_) async => account);

  void mockLoadCurrentAccountError() =>
      mockLoadCurrentAccountCall().thenThrow(Exception());

  setUp(() {
    loadCurrentUser = MockLoadCurrentUser();
    sut = GetxSplashPresenter(loadCurrentUser: loadCurrentUser);
    mockLoadCurrentAccount(account: FakeUserFactory.makeEntity());
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);

    verify(loadCurrentUser.load()).called(1);
  });

  test('Should go to surveys page on success', () async {
    sut.navigateToStream.listen(
      expectAsync1(
        (page) => expect(page, '/login'),
      ),
    );

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(
      expectAsync1(
        (page) => expect(page, '/login'),
      ),
    );

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on null token', () async {
    mockLoadCurrentAccount(account: UserEntity(token: null));

    sut.navigateToStream.listen(
      expectAsync1(
        (page) => expect(page, '/login'),
      ),
    );

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on error', () async {
    mockLoadCurrentAccountError();

    sut.navigateToStream.listen(
      expectAsync1(
        (page) => expect(page, '/login'),
      ),
    );

    await sut.checkAccount(durationInSeconds: 0);
  });
}
