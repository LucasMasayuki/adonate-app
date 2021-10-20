import 'package:dio/dio.dart';
import 'package:clean_architeture_flutter/app/data/api/dio_client.dart';
import 'package:clean_architeture_flutter/app/infra/api/dio_adapter.dart';

DioClient makeHttpAdapter() => DioAdapter(Dio());
