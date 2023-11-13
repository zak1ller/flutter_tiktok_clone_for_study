import 'package:flutter/cupertino.dart';

class ColorManager {
  static bool isDarkMode(BuildContext context) =>
      MediaQuery.of(context).platformBrightness == Brightness.dark;
}
