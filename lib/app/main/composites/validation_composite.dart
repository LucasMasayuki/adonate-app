import 'package:clean_architeture_flutter/app/presentation/protocols/validation.dart';
import 'package:clean_architeture_flutter/app/validation/protocols/field_validation.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  ValidationError? validate({required String field, required Map input}) {
    ValidationError? error;
    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(input);
      if (error != ValidationError.nothing) {
        return error;
      }
    }
    return error;
  }
}
