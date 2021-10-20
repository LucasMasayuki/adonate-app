import 'package:flutter/material.dart';
import 'package:clean_architeture_flutter/app/ui/components/spinner_dialog.dart';

mixin LoadingManager {
  void handleLoading(BuildContext context, Stream<bool?> stream) {
    stream.listen((isLoading) {
      if (isLoading == true) {
        showLoading(context);
      } else {
        hideLoading(context);
      }
    });
  }
}
