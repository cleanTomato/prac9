import 'package:flutter/material.dart';

class UILogicService {
  const UILogicService();

  String getButtonText(int currentVolume, int dailyGoal) {
    final progress = dailyGoal > 0 ? currentVolume / dailyGoal : 0;

    if (progress >= 1.0) return 'Отлично!';
    if (progress >= 0.8) return 'Почти у цели!';
    if (progress >= 0.5) return 'Так держать!';
    return 'Добавить жидкость';
  }

  Color getButtonColor(int currentVolume, int dailyGoal) {
    final progress = dailyGoal > 0 ? currentVolume / dailyGoal : 0;

    if (progress >= 1.0) return Colors.green;
    if (progress >= 0.7) return Colors.blue;
    if (progress >= 0.4) return Colors.lightBlue;
    return Colors.blueAccent;
  }











  Color getProgressColor(double progress) {
    if (progress >= 1.0) return Colors.green;
    if (progress >= 0.7) return Colors.blue;
    if (progress >= 0.4) return Colors.lightBlue;
    return Colors.blueAccent;
  }

  Color getWaterColor(double progress) {
    if (progress >= 1.0) return Colors.green;
    if (progress >= 0.7) return Colors.blue;
    if (progress >= 0.4) return Colors.lightBlue;
    return Colors.blue[200]!;
  }
}