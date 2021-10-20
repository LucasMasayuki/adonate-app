import 'package:adonate_app/app/data/usecases/save_current_user.dart';
import 'package:adonate_app/app/domain/usecases/save_current_user.dart';
import 'package:adonate_app/app/main/factories/cache/shared_preferences_adapter_factory.dart';

SaveCurrentUser makeLocalSaveCurrentUser() => LocalSaveCurrentUser(
      saveSharedPreferences: makeSharedPreferencesAdapter(),
    );
