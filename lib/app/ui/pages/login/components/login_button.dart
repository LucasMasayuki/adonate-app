import 'package:flutter/material.dart';
import 'package:clean_architeture_flutter/app/ui/helpers/i18n/resources.dart';

class LoginButton extends StatelessWidget {
  final Stream<bool?> isFormValidStream;
  final void Function()? auth;

  const LoginButton({
    required this.isFormValidStream,
    required this.auth,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: snapshot.data == true ? auth : null,
          child: Text(R.string.enter.toUpperCase()),
        );
      },
    );
  }
}
