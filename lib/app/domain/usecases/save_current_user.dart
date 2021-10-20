import 'package:clean_architeture_flutter/app/domain/entities/user_entity.dart';

abstract class SaveCurrentUser {
  Future<void> save(UserEntity user);
}
