import 'package:flutter/material.dart';
import 'package:clean_architeture_flutter/app/main/factories/pages/signup/signup_presenter_factory.dart';
import 'package:clean_architeture_flutter/app/ui/pages/signup/signup_page.dart';

Widget makeSignUpPage() => SignUpPage(makeGetxSignUpPresenter());
