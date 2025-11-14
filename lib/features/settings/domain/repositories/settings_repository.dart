import 'package:flutter/foundation.dart';

class SettingsRepository extends ChangeNotifier {
  int _dailyGoal = 2000;
  bool _isDarkMode = false;

  int get dailyGoal => _dailyGoal;
  bool get isDarkMode => _isDarkMode;

  void updateDailyGoal(int goal) {
    if (_dailyGoal != goal) {
      _dailyGoal = goal;
      notifyListeners();
    }
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void resetToDefault() {
    _dailyGoal = 2000;
    _isDarkMode = false;
    notifyListeners();
  }
}