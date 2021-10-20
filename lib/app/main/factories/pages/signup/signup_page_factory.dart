import 'package:flutter/material.dart';
import 'package:adonate_app/app/main/factories/pages/signup/signup_presenter_factory.dart';
import 'package:adonate_app/app/ui/pages/signup/signup_page.dart';

Widget makeSignUpPage() => SignUpPage(makeGetxSignUpPresenter());
