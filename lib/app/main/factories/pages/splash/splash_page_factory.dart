import 'package:flutter/material.dart';
import 'package:clean_architeture_flutter/app/ui/factories/pages/splash/splash_presenter_factory.dart';
import 'package:clean_architeture_flutter/app/ui/pages/splash/splash_page.dart';

Widget makeSplashPage() => SplashPage(presenter: makeGetxSplashPresenter());
