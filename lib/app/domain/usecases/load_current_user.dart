import 'package:clean_architeture_flutter/app/domain/entities/user_entity.dart';

abstract class LoadCurrentUser {
  Future<UserEntity> load();
}
