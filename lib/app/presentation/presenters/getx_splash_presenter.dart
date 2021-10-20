import 'package:get/get.dart';

import 'package:adonate_app/app/domain/usecases/load_current_user.dart';
import 'package:adonate_app/app/presentation/mixins/navigation_manager.dart';
import 'package:adonate_app/app/ui/pages/splash/splash_presenter.dart';

class GetxSplashPresenter extends GetxController
    with NavigationManager
    implements SplashPresenter {
  final LoadCurrentUser loadCurrentUser;

  GetxSplashPresenter({required this.loadCurrentUser});

  Future<void> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final user = await loadCurrentUser.load();
      navigateTo = user.token == null ? '/login' : '/home';
    } catch (error) {
      navigateTo = '/login';
    }
  }
}
