import 'package:flutter/material.dart';
import 'package:clean_architeture_flutter/app/ui/helpers/i18n/resources.dart';
import 'package:clean_architeture_flutter/app/ui/helpers/ui_error.dart';

class NameInput extends StatelessWidget {
  final Stream<UIError?> nameErrorStream;
  final void Function(String) validateName;

  const NameInput({
    required this.nameErrorStream,
    required this.validateName,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UIError?>(
      stream: nameErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: R.string.name,
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColorLight,
            ),
            errorText: snapshot.hasData ? snapshot.data!.description : null,
          ),
          keyboardType: TextInputType.name,
          onChanged: validateName,
        );
      },
    );
  }
}
