import 'package:clean_architeture_flutter/app/data/usecases/remote_authentication.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/authentication.dart';
import 'package:clean_architeture_flutter/app/main/factories/api/graphql_client_factory.dart';

Authentication makeRemoteAuthentication() => RemoteAuthentication(
      graphQlClient: makeGraphQLAdapter(),
    );
