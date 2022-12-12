import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
    bool isDark = false;

    void toggleDark (bool value) {
      isDark = value;
      notifyListeners();
    }
}