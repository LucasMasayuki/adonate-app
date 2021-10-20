import 'package:flutter/material.dart';
import 'package:clean_architeture_flutter/app/ui/components/headline1.dart';
import 'package:clean_architeture_flutter/app/ui/components/inputs/email_input.dart';
import 'package:clean_architeture_flutter/app/ui/components/inputs/password_input.dart';
import 'package:clean_architeture_flutter/app/ui/components/login_header.dart';
import 'package:clean_architeture_flutter/app/ui/helpers/i18n/resources.dart';
import 'package:clean_architeture_flutter/app/ui/mixins/keyboard_manager.dart';
import 'package:clean_architeture_flutter/app/ui/mixins/loading_manager.dart';
import 'package:clean_architeture_flutter/app/ui/mixins/navigation_manager.dart';
import 'package:clean_architeture_flutter/app/ui/mixins/ui_error_manager.dart';
import 'package:clean_architeture_flutter/app/ui/pages/login/components/login_button.dart';
import 'package:clean_architeture_flutter/app/ui/pages/login/login_presenter.dart';

class LoginPage extends StatelessWidget
    with KeyboardManager, LoadingManager, UIErrorManager, NavigationManager {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          handleLoading(context, presenter.isLoadingStream);
          handleMainError(context, presenter.mainErrorStream);
          handleNavigation(presenter.navigateToStream, clear: true);

          return GestureDetector(
            onTap: () => hideKeyboard(context),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LoginHeader(),
                  Headline1(text: R.string.login),
                  Padding(
                    padding: EdgeInsets.all(32),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          EmailInput(
                            emailErrorStream: presenter.emailErrorStream,
                            validateEmail: presenter.validateEmail,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 32),
                            child: PasswordInput(
                              passwordErrorStream:
                                  presenter.passwordErrorStream,
                              validatePassword: presenter.validatePassword,
                            ),
                          ),
                          LoginButton(
                            isFormValidStream: presenter.isFormValidStream,
                            auth: presenter.auth,
                          ),
                          TextButton.icon(
                            onPressed: presenter.goToSignUp,
                            icon: Icon(Icons.person),
                            label: Text(
                              R.string.addAccount,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
