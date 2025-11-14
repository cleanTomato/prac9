import 'package:flutter/material.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/settings/domain/services/settings_service.dart';
import 'package:prac9/app/routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // Получаем сервис настроек через GetIt
  late final SettingsService _settingsService;

  @override
  void initState() {
    super.initState();
    _settingsService = serviceLocator<SettingsService>();
    // Подписываемся на изменения темы для перерисовки UI
    _settingsService.addListener(_onSettingsChanged);
  }

  void _onSettingsChanged() => setState(() {});

  @override
  void dispose() {
    _settingsService.removeListener(_onSettingsChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Трекер водного баланса',
      theme: _settingsService.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}