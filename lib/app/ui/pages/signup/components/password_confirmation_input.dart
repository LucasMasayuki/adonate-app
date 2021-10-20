import 'package:flutter/material.dart';
import 'package:clean_architeture_flutter/app/ui/helpers/i18n/resources.dart';
import 'package:clean_architeture_flutter/app/ui/helpers/ui_error.dart';

class PasswordConfirmationInput extends StatelessWidget {
  final Stream<UIError?> passwordConfirmationErrorStream;
  final void Function(String) validatePasswordConfirmation;

  const PasswordConfirmationInput({
    required this.passwordConfirmationErrorStream,
    required this.validatePasswordConfirmation,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UIError?>(
      stream: passwordConfirmationErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: R.string.confirmPassword,
            icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
            errorText: snapshot.hasData ? snapshot.data!.description : null,
          ),
          obscureText: true,
          onChanged: validatePasswordConfirmation,
        );
      },
    );
  }
}
