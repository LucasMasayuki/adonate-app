import 'package:equatable/equatable.dart';
import 'package:clean_architeture_flutter/app/presentation/protocols/validation.dart';
import 'package:clean_architeture_flutter/app/validation/protocols/field_validation.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;

  List get props => [field];

  RequiredFieldValidation(this.field);

  ValidationError validate(Map input) =>
      input[field] != null && (input[field] as String).isNotEmpty
          ? ValidationError.nothing
          : ValidationError.requiredField;
}
