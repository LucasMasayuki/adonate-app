import 'package:adonate_app/app/main/builders/validation_builder.dart';
import 'package:adonate_app/app/main/composites/validation_composite.dart';
import 'package:adonate_app/app/presentation/protocols/validation.dart';
import 'package:adonate_app/app/validation/protocols/field_validation.dart';

Validation makeSignUpValidation() =>
    ValidationComposite(makeSignUpValidations());

List<FieldValidation> makeSignUpValidations() => [
      ...ValidationBuilder.field('name').required().min(3).build(),
      ...ValidationBuilder.field('email').required().email().build(),
      ...ValidationBuilder.field('password').required().min(3).build(),
      ...ValidationBuilder.field('passwordConfirmation')
          .required()
          .sameAs('password')
          .build()
    ];
