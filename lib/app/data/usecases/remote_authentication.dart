import 'package:adonate_app/app/data/api/graphql.dart';
import 'package:adonate_app/app/data/api/http_error.dart';
import 'package:adonate_app/app/data/models/remote_user_model.dart';
import 'package:adonate_app/app/domain/entities/user_entity.dart';
import 'package:adonate_app/app/domain/helpers/domain_errors.dart';
import 'package:adonate_app/app/domain/usecases/authentication.dart';
import 'package:adonate_app/app/main/graphql/auth.dart';

class RemoteAuthentication implements Authentication {
  final GraphQl graphQlClient;

  RemoteAuthentication({required this.graphQlClient});

  Future<UserEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();

    try {
      final responseData = await graphQlClient.query(LOGIN_QUERY, body);
      if (responseData == null) {
        throw DomainError.unexpected;
      }

      return RemoteUserModel.fromJson(responseData).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({
    required this.email,
    required this.password,
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(
        email: params.email,
        password: params.password,
      );

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(
        {
          'email': email,
          'password': password,
        },
      );
}
