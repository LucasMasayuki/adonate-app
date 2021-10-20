import 'package:equatable/equatable.dart';
import 'package:clean_architeture_flutter/app/domain/entities/user_entity.dart';

abstract class AddUser {
  Future<UserEntity> add(AddUserParams params);
}

class AddUserParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  List get props => [
        name,
        email,
        password,
        passwordConfirmation,
      ];

  AddUserParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });
}
