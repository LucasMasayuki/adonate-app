import 'package:clean_architeture_flutter/app/data/usecases/remote_add_user_.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/add_user.dart';
import 'package:clean_architeture_flutter/app/main/factories/api/graphql_client_factory.dart';

AddUser makeRemoteAddUser() => RemoteAddUser(
      graphQlClient: makeGraphQLAdapter(),
    );
