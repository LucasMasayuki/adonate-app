import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architeture_flutter/app/presentation/protocols/validation.dart';
import 'package:clean_architeture_flutter/app/validation/validators/email_validation.dart';

void main() {
  EmailValidation? sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return nothing if email is empty', () {
    expect(sut!.validate({'any_field': ''}), ValidationError.nothing);
  });

  test('Should return nothing if email is null', () {
    expect(sut!.validate({}), ValidationError.nothing);

    expect(
      sut!.validate({'any_field': null}),
      ValidationError.nothing,
    );
  });

  test('Should return null if email is valid', () {
    expect(
      sut!.validate({'any_field': 'test.test@gmail.com'}),
      ValidationError.nothing,
    );
  });

  test('Should return error if email is invalid', () {
    expect(
      sut!.validate({'any_field': 'test'}),
      ValidationError.invalidField,
    );
  });
}
