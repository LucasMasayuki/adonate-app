import 'package:adonate_app/app/data/usecases/remote_add_user_.dart';
import 'package:adonate_app/app/domain/usecases/add_user.dart';
import 'package:adonate_app/app/main/factories/api/graphql_client_factory.dart';

AddUser makeRemoteAddUser() => RemoteAddUser(
      graphQlClient: makeGraphQLAdapter(),
    );
