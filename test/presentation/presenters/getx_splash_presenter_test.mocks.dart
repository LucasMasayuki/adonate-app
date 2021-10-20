// Mocks generated by Mockito 5.0.10 from annotations
// in adonate_app/test/presentation/presenters/getx_splash_presenter_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:adonate_app/app/domain/entities/user_entity.dart'
    as _i2;
import 'package:adonate_app/app/domain/usecases/load_current_user.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeUserEntity extends _i1.Fake implements _i2.UserEntity {}

/// A class which mocks [LoadCurrentUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoadCurrentUser extends _i1.Mock implements _i3.LoadCurrentUser {
  MockLoadCurrentUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.UserEntity> load() =>
      (super.noSuchMethod(Invocation.method(#load, []),
              returnValue: Future<_i2.UserEntity>.value(_FakeUserEntity()))
          as _i4.Future<_i2.UserEntity>);
}
