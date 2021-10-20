import 'package:flutter/material.dart';
import 'package:adonate_app/app/ui/factories/pages/splash/splash_presenter_factory.dart';
import 'package:adonate_app/app/ui/pages/splash/splash_page.dart';

Widget makeSplashPage() => SplashPage(presenter: makeGetxSplashPresenter());
