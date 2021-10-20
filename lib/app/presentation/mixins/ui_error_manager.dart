import 'package:get/get.dart';
import 'package:clean_architeture_flutter/app/ui/helpers/ui_error.dart';

mixin UIErrorManager on GetxController {
  final _mainError = Rx<UIError>(UIError.unexpected);

  Stream<UIError?> get mainErrorStream => _mainError.stream;

  set mainError(UIError value) => _mainError.value = value;
}
