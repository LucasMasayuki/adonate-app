import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architeture_flutter/app/presentation/protocols/validation.dart';
import 'package:clean_architeture_flutter/app/validation/validators/required_field_validation.dart';

void main() {
  RequiredFieldValidation? sut;

  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    expect(sut!.validate({'any_field': 'any_value'}), ValidationError.nothing);
  });

  test('Should return error if value is empty', () {
    expect(
      sut!.validate({'any_field': ''}),
      ValidationError.requiredField,
    );
  });

  test('Should return error if value is null', () {
    expect(sut!.validate({}), ValidationError.requiredField);
    expect(
      sut!.validate({'any_field': null}),
      ValidationError.requiredField,
    );
  });
}
