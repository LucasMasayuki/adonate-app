import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:clean_architeture_flutter/app/data/api/graphql.dart';
import 'package:clean_architeture_flutter/app/infra/api/graphql_adapter.dart';
import 'package:clean_architeture_flutter/app/main/factories/api/api_url_factory.dart';

GraphQl makeGraphQLAdapter() => GraphQlAdapter(
      GraphQLClient(
        cache: GraphQLCache(),
        link: HttpLink(makeApiUrl('graphql')),
      ),
    );
