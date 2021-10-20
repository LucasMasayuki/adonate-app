import 'package:flutter/material.dart';
import 'package:clean_architeture_flutter/app/ui/mixins/navigation_manager.dart';
import 'package:clean_architeture_flutter/app/ui/pages/splash/splash_presenter.dart';

class SplashPage extends StatelessWidget with NavigationManager {
  final SplashPresenter presenter;

  SplashPage({required this.presenter});

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pet diary'),
      ),
      body: Builder(
        builder: (context) {
          handleNavigation(
            presenter.navigateToStream,
            clear: true,
          );

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
