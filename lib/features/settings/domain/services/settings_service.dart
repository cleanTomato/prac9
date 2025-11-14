import 'package:flutter/foundation.dart';

/// Сервис для управления настройками приложения
/// Отвечает за хранение и обновление пользовательских предпочтений
class SettingsService extends ChangeNotifier {
  int _dailyGoal = 2000;
  bool _isDarkMode = false;

  int get dailyGoal => _dailyGoal;
  bool get isDarkMode => _isDarkMode;

  /// Обновляет дневную цель потребления воды
  void updateDailyGoal(int goal) {
    _dailyGoal = goal;
    notifyListeners();
  }

  /// Переключает между светлой и тёмной темой
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}