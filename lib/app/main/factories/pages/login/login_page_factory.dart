import 'package:flutter/material.dart';
import 'package:adonate_app/app/main/factories/pages/login/login_presenter_factory.dart';
import 'package:adonate_app/app/ui/pages/login/login_page.dart';

Widget makeLoginPage() => LoginPage(makeGetxLoginPresenter());
