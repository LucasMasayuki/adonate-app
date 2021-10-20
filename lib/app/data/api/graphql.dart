import 'package:graphql_flutter/graphql_flutter.dart';

abstract class GraphQl {
  Future<T> query<T>(String query, Map<String, dynamic> variables);
  Future<T> mutate<T>(String mutation, Map<String, dynamic> variables);
  dynamic handleResponse(QueryResult response) {}
}
