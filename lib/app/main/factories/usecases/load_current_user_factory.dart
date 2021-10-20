import 'package:clean_architeture_flutter/app/data/usecases/local_load_current_user.dart';
import 'package:clean_architeture_flutter/app/domain/usecases/load_current_user.dart';
import 'package:clean_architeture_flutter/app/main/factories/cache/shared_preferences_adapter_factory.dart';

LoadCurrentUser makeLocalLoadCurrentUser() => LocalLoadCurrentUser(
      fetchSharedPreferences: makeSharedPreferencesAdapter(),
    );
