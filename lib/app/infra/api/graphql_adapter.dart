import 'dart:async';

import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:clean_architeture_flutter/app/data/api/graphql.dart';
import 'package:clean_architeture_flutter/app/data/api/http_error.dart';

class GraphQlAdapter implements GraphQl {
  final GraphQLClient client;

  GraphQlAdapter(this.client);

  Future<T> query<T>(String query, Map<String, dynamic> variables) async {
    final options = QueryOptions(
      document: gql(query),
      variables: variables,
    );

    final QueryResult queryResult = await client.query(options);
    return handleResponse(queryResult);
  }

  Future<T> mutate<T>(String query, Map<String, dynamic> variables) async {
    final options = MutationOptions(
      document: gql(query),
      variables: variables,
    );

    final QueryResult queryResult = await client.mutate(options);
    return handleResponse(queryResult);
  }

  dynamic handleResponse(QueryResult response) {
    if (!response.hasException) {
      return response.data;
    }

    if (response.exception!.linkException is HttpLinkServerException) {
      final exception =
          response.exception!.linkException as HttpLinkServerException;

      switch (exception.response.statusCode) {
        case HttpStatus.noContent:
          return null;
        case HttpStatus.badRequest:
          throw HttpError.badRequest;
        case HttpStatus.unauthorized:
          throw HttpError.unauthorized;
        case HttpStatus.forbidden:
          throw HttpError.forbidden;
        case HttpStatus.notFound:
          throw HttpError.notFound;

        default:
          throw HttpError.serverError;
      }
    }

    throw HttpError.serverError;
  }
}
