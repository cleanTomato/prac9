import 'package:flutter/material.dart';
import 'package:prac9/app/app.dart';
import 'package:prac9/core/di/service_locator.dart';

void main() {
  // Инициализация GetIt для зависимостей
  setupServiceLocator();
  runApp(const App());
}