import 'package:clean_architeture_flutter/app/data/cache/save_shared_preferences.dart';
import 'package:clean_architeture_flutter/app/domain/entities/user_entity.dart';
import 'package:clean_architeture_flutter/app/domain/helpers/domain_errors.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/save_current_user.dart';

class LocalSaveCurrentUser implements SaveCurrentUser {
  final SaveSharedPreferences saveSharedPreferences;

  LocalSaveCurrentUser({required this.saveSharedPreferences});

  Future<void> save(UserEntity user) async {
    try {
      await saveSharedPreferences.save(key: 'token', value: user.token!);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
