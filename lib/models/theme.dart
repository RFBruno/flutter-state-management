import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
    bool isDark = true;

    void toggleDark (bool value) {
      isDark = value;
      notifyListeners();
    }
}