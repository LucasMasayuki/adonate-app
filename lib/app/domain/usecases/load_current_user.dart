import 'package:adonate_app/app/domain/entities/user_entity.dart';

abstract class LoadCurrentUser {
  Future<UserEntity> load();
}
