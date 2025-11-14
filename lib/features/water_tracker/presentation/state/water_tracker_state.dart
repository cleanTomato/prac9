import 'package:flutter/foundation.dart';
import 'package:prac9/features/water_tracker/data/models/water_intake.dart';

/// Состояние трекера воды - управляет данными о потреблении воды
/// Использует ChangeNotifier для реактивного обновления UI
class WaterTrackerState extends ChangeNotifier {
  final List<WaterIntake> _intakes = [];

  List<WaterIntake> get intakes => List.unmodifiable(_intakes);

  void addIntake(WaterIntake intake) {
    _intakes.add(intake);
    notifyListeners();
  }

  void deleteIntake(String id) {
    _intakes.removeWhere((intake) => intake.id == id);
    notifyListeners();
  }

  /// Общий объем выпитой воды с учетом коэффициентов напитков
  int get totalIntake {
    return _intakes.fold(0, (sum, intake) => sum + intake.effectiveVolume);
  }

  /// Прогресс относительно дневной цели (от 0.0 до 1.0)
  double getProgress(int dailyGoal) {
    return dailyGoal > 0 ? totalIntake / dailyGoal : 0.0;
  }
}