import 'package:flutter_test/flutter_test.dart';
import 'package:adonate_app/app/main/factories/pages/login/login_validation_factory.dart';
import 'package:adonate_app/app/validation/validators/email_validation.dart';
import 'package:adonate_app/app/validation/validators/min_length_validation.dart';
import 'package:adonate_app/app/validation/validators/required_field_validation.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
      MinLengthValidation(field: 'password', size: 3)
    ]);
  });
}
