import 'package:equatable/equatable.dart';
import 'package:adonate_app/app/domain/entities/user_entity.dart';

abstract class Authentication {
  Future<UserEntity> auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String email;
  final String password;

  List get props => [email, password];

  AuthenticationParams({required this.email, required this.password});
}
