import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:adonate_app/app/data/api/graphql.dart';
import 'package:adonate_app/app/infra/api/graphql_adapter.dart';
import 'package:adonate_app/app/main/factories/api/api_url_factory.dart';

GraphQl makeGraphQLAdapter() => GraphQlAdapter(
      GraphQLClient(
        cache: GraphQLCache(),
        link: HttpLink(makeApiUrl('graphql')),
      ),
    );
