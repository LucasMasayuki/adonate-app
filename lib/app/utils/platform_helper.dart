import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformHelper {
  bool isIOS() => !kIsWeb && Platform.isIOS;
  bool isAndroid() => !kIsWeb && Platform.isAndroid;
  bool isWeb() => kIsWeb;
}
