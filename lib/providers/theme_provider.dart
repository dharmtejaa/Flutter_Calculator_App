import 'package:calculator/constants/colors.dart';
import 'package:flutter/material.dart';

//light theme mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    // ignore: deprecated_member_use
    background: Colors.white,
    primary: kLightGreyColor,
    onPrimary: kLightBlueColor,
    secondary: kBlackColor,
    onSecondary: kPrimaryDarkBlueColor,
  ),
);

//dark theme mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    // ignore: deprecated_member_use
    background: Colors.black45,
    primary: kDarkGreyColor,
    onPrimary: kDarkBlueColor,
    secondary: kWhiteColor,
    onSecondary: kPrimaryLightBlueColor,
  ),
);

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkMode;
  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    themeData = _themeData == darkMode ? lightMode : darkMode;
    notifyListeners();
  }
}