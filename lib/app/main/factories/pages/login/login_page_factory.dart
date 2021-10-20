import 'package:flutter/material.dart';
import 'package:clean_architeture_flutter/app/main/factories/pages/login/login_presenter_factory.dart';
import 'package:clean_architeture_flutter/app/ui/pages/login/login_page.dart';

Widget makeLoginPage() => LoginPage(makeGetxLoginPresenter());
