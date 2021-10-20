import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architeture_flutter/app/presentation/protocols/validation.dart';
import 'package:clean_architeture_flutter/app/validation/validators/compare_fields_validation.dart';

void main() {
  CompareFieldsValidation? sut;

  setUp(() {
    sut = CompareFieldsValidation(
      field: 'any_field',
      fieldToCompare: 'other_field',
    );
  });

  test('Should return null on invalid cases', () {
    expect(
      sut!.validate({'any_field': 'any_value'}),
      ValidationError.nothing,
    );
    expect(
      sut!.validate({'any_field': null}),
      ValidationError.nothing,
    );
    expect(
      sut!.validate({'other_field': 'any_value'}),
      ValidationError.nothing,
    );
    expect(
      sut!.validate({'other_field': null}),
      ValidationError.nothing,
    );
    expect(
      sut!.validate({'any_field': null, 'other_field': null}),
      ValidationError.nothing,
    );
    expect(
      sut!.validate({}),
      ValidationError.nothing,
    );
  });

  test('Should return error if values are not equal', () {
    final formData = {'any_field': 'any_value', 'other_field': 'other_value'};
    expect(sut!.validate(formData), ValidationError.invalidField);
  });

  test('Should return null if values are equal', () {
    final formData = {'any_field': 'any_value', 'other_field': 'any_value'};
    expect(sut!.validate(formData), ValidationError.nothing);
  });
}
