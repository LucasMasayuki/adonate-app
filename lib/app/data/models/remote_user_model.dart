import 'package:clean_architeture_flutter/app/data/api/http_error.dart';
import 'package:clean_architeture_flutter/app/domain/entities/user_entity.dart';

class RemoteUserModel {
  final String token;

  RemoteUserModel({required this.token});

  factory RemoteUserModel.fromJson(Map json) {
    if (!json.containsKey('token')) {
      throw HttpError.invalidData;
    }

    return RemoteUserModel(token: json['token']);
  }

  UserEntity toEntity() => UserEntity(token: token);
}
