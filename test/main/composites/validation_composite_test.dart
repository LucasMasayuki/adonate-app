import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architeture_flutter/app/main/composites/validation_composite.dart';
import 'package:clean_architeture_flutter/app/presentation/protocols/validation.dart';
import 'package:clean_architeture_flutter/app/validation/protocols/field_validation.dart';

import 'validation_composite_test.mocks.dart';

@GenerateMocks([FieldValidation])
void main() {
  late ValidationComposite sut;
  late MockFieldValidation validation1;
  late MockFieldValidation validation2;
  late MockFieldValidation validation3;

  void mockValidation1(ValidationError error) =>
      when(validation1.validate(any)).thenReturn(error);

  void mockValidation2(ValidationError error) =>
      when(validation2.validate(any)).thenReturn(error);

  void mockValidation3(ValidationError error) =>
      when(validation3.validate(any)).thenReturn(error);

  setUp(() {
    validation1 = MockFieldValidation();
    when(validation1.field).thenReturn('other_field');
    mockValidation1(ValidationError.nothing);
    validation2 = MockFieldValidation();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(ValidationError.nothing);
    validation3 = MockFieldValidation();
    when(validation3.field).thenReturn('any_field');
    mockValidation3(ValidationError.nothing);
    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return null if all validations returns null or empty', () {
    final error = sut.validate(
      field: 'any_field',
      input: {'any_field': 'any_value'},
    );

    expect(error, ValidationError.nothing);
  });

  test('Should return the first error', () {
    mockValidation1(ValidationError.requiredField);
    mockValidation2(ValidationError.requiredField);
    mockValidation3(ValidationError.invalidField);

    final error = sut.validate(
      field: 'any_field',
      input: {'any_field': 'any_value'},
    );

    expect(error, ValidationError.requiredField);
  });
}
