import 'package:adonate_app/app/data/usecases/remote_authentication.dart';
import 'package:adonate_app/app/domain/usecases/authentication.dart';
import 'package:adonate_app/app/main/factories/api/graphql_client_factory.dart';

Authentication makeRemoteAuthentication() => RemoteAuthentication(
      graphQlClient: makeGraphQLAdapter(),
    );
