import 'package:equatable/equatable.dart';
import 'package:clean_architeture_flutter/app/presentation/protocols/validation.dart';
import 'package:clean_architeture_flutter/app/validation/protocols/field_validation.dart';

class EmailValidation extends Equatable implements FieldValidation {
  final String field;

  List get props => [field];

  EmailValidation(this.field);

  ValidationError validate(Map input) {
    final regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (input[field] == null) {
      return ValidationError.nothing;
    }

    final isValid =
        input[field].isNotEmpty != true || regex.hasMatch(input[field]!);

    return isValid ? ValidationError.nothing : ValidationError.invalidField;
  }
}
