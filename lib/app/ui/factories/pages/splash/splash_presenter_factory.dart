import 'package:adonate_app/app/main/factories/usecases/load_current_user_factory.dart';
import 'package:adonate_app/app/presentation/presenters/getx_splash_presenter.dart';
import 'package:adonate_app/app/ui/pages/splash/splash_presenter.dart';

SplashPresenter makeGetxSplashPresenter() => GetxSplashPresenter(
      loadCurrentUser: makeLocalLoadCurrentUser(),
    );
