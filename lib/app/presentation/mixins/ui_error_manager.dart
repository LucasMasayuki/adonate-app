import 'package:get/get.dart';
import 'package:adonate_app/app/ui/helpers/ui_error.dart';

mixin UIErrorManager on GetxController {
  final _mainError = Rx<UIError>(UIError.unexpected);

  Stream<UIError?> get mainErrorStream => _mainError.stream;

  set mainError(UIError value) => _mainError.value = value;
}
