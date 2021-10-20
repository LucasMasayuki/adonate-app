import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architeture_flutter/app/main/factories/pages/signup/signup_validation_factory.dart';
import 'package:clean_architeture_flutter/app/validation/validators/compare_fields_validation.dart';
import 'package:clean_architeture_flutter/app/validation/validators/email_validation.dart';
import 'package:clean_architeture_flutter/app/validation/validators/min_length_validation.dart';
import 'package:clean_architeture_flutter/app/validation/validators/required_field_validation.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeSignUpValidations();

    expect(
      validations,
      [
        RequiredFieldValidation('name'),
        MinLengthValidation(field: 'name', size: 3),
        RequiredFieldValidation('email'),
        EmailValidation('email'),
        RequiredFieldValidation('password'),
        MinLengthValidation(field: 'password', size: 3),
        RequiredFieldValidation('passwordConfirmation'),
        CompareFieldsValidation(
          field: 'passwordConfirmation',
          fieldToCompare: 'password',
        ),
      ],
    );
  });
}
