import 'package:adonate_app/app/data/cache/fetch_shared_preferences.dart';
import 'package:adonate_app/app/domain/entities/user_entity.dart';
import 'package:adonate_app/app/domain/helpers/domain_errors.dart';
import 'package:adonate_app/app/domain/usecases/load_current_user.dart';

class LocalLoadCurrentUser implements LoadCurrentUser {
  final FetchSharedPreferences fetchSharedPreferences;

  LocalLoadCurrentUser({
    required this.fetchSharedPreferences,
  });

  Future<UserEntity> load() async {
    try {
      final token = await fetchSharedPreferences.fetch('token');
      return UserEntity(token: token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
