import 'package:equatable/equatable.dart';

import 'package:clean_architeture_flutter/app/presentation/protocols/validation.dart';
import 'package:clean_architeture_flutter/app/validation/protocols/field_validation.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  final String field;
  final int size;

  List get props => [field, size];

  MinLengthValidation({
    required this.field,
    required this.size,
  });

  ValidationError validate(Map input) =>
      input[field] != null && input[field].length >= size
          ? ValidationError.nothing
          : ValidationError.invalidField;
}
