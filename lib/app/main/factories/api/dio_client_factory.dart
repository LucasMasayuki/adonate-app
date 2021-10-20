import 'package:dio/dio.dart';
import 'package:adonate_app/app/data/api/dio_client.dart';
import 'package:adonate_app/app/infra/api/dio_adapter.dart';

DioClient makeHttpAdapter() => DioAdapter(Dio());
