import 'package:clean_architeture_flutter/app/main/factories/usecases/load_current_user_factory.dart';
import 'package:clean_architeture_flutter/app/presentation/presenters/getx_splash_presenter.dart';
import 'package:clean_architeture_flutter/app/ui/pages/splash/splash_presenter.dart';

SplashPresenter makeGetxSplashPresenter() => GetxSplashPresenter(
      loadCurrentUser: makeLocalLoadCurrentUser(),
    );
