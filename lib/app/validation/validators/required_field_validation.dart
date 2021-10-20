import 'package:equatable/equatable.dart';
import 'package:adonate_app/app/presentation/protocols/validation.dart';
import 'package:adonate_app/app/validation/protocols/field_validation.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;

  List get props => [field];

  RequiredFieldValidation(this.field);

  ValidationError validate(Map input) =>
      input[field] != null && (input[field] as String).isNotEmpty
          ? ValidationError.nothing
          : ValidationError.requiredField;
}
