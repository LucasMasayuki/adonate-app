import 'package:clean_architeture_flutter/app/main/factories/pages/login/login_validation_factory.dart';
import 'package:clean_architeture_flutter/app/main/factories/usecases/authentication_factory.dart';
import 'package:clean_architeture_flutter/app/main/factories/usecases/save_current_user_factory.dart';
import 'package:clean_architeture_flutter/app/presentation/presenters/getx_login_presenter.dart';
import 'package:clean_architeture_flutter/app/ui/pages/login/login_presenter.dart';

LoginPresenter makeGetxLoginPresenter() => GetxLoginPresenter(
      authentication: makeRemoteAuthentication(),
      validation: makeLoginValidation(),
      saveCurrentUser: makeLocalSaveCurrentUser(),
    );
