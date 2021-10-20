import 'package:clean_architeture_flutter/app/main/factories/pages/login/login_page_factory.dart';
import 'package:clean_architeture_flutter/app/main/factories/pages/signup/signup_page_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'main/factories/pages/splash/splash_page_factory.dart';
import 'ui/theme/app_theme.dart';

// Main App Widget
class CleanArchitetureFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final routeObserver = Get.put<RouteObserver>(
      RouteObserver<PageRoute>(),
    );

    return GetMaterialApp(
      title: 'Clean architeture flutter',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      navigatorObservers: [routeObserver],
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: makeSplashPage,
          transition: Transition.fade,
        ),
        GetPage(
          name: '/login',
          page: makeLoginPage,
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/signup',
          page: makeSignUpPage,
        ),
      ],
    );
  }
}
