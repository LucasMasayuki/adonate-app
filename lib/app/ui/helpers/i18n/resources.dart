import 'package:flutter/widgets.dart';
import 'package:clean_architeture_flutter/app/ui/helpers/i18n/string/pt_br.dart';
import 'package:clean_architeture_flutter/app/ui/helpers/i18n/string/translation.dart';

class R {
  static Translation string = PtBr();

  static void load(Locale locale) {
    switch (locale.toString()) {
      default:
        string = PtBr();
        break;
    }
  }
}
