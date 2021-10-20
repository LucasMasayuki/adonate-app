import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architeture_flutter/app/presentation/protocols/validation.dart';
import 'package:clean_architeture_flutter/app/validation/validators/min_length_validation.dart';

void main() {
  MinLengthValidation? sut;

  setUp(() {
    sut = MinLengthValidation(field: 'any_field', size: 5);
  });

  test('Should return error if value is empty', () {
    expect(
      sut!.validate({'any_field': ''}),
      ValidationError.invalidField,
    );
  });

  test('Should return error if value is null', () {
    expect(sut!.validate({}), ValidationError.invalidField);
    expect(
      sut!.validate({'any_field': null}),
      ValidationError.invalidField,
    );
  });

  test('Should return error if value is less than min size', () {
    expect(
        sut!.validate(
          {'any_field': faker.randomGenerator.string(4, min: 1)},
        ),
        ValidationError.invalidField);
  });

  test('Should return null if value is equal than min size', () {
    expect(
      sut!.validate(
        {'any_field': faker.randomGenerator.string(5, min: 5)},
      ),
      ValidationError.nothing,
    );
  });

  test('Should return null if value is bigger than min size', () {
    expect(
      sut!.validate(
        {'any_field': faker.randomGenerator.string(10, min: 6)},
      ),
      ValidationError.nothing,
    );
  });
}
