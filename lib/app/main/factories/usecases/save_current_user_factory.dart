import 'package:clean_architeture_flutter/app/data/usecases/save_current_user.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/save_current_user.dart';
import 'package:clean_architeture_flutter/app/main/factories/cache/shared_preferences_adapter_factory.dart';

SaveCurrentUser makeLocalSaveCurrentUser() => LocalSaveCurrentUser(
      saveSharedPreferences: makeSharedPreferencesAdapter(),
    );
