import 'package:flutter/material.dart';
import 'package:prac9/app/routes.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/settings/domain/repositories/settings_repository.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final SettingsRepository _settingsRepository = serviceLocator<SettingsRepository>();

  @override
  void initState() {
    super.initState();
    _settingsRepository.addListener(_onSettingsChanged);
  }

  void _onSettingsChanged() => setState(() {});

  @override
  void dispose() {
    _settingsRepository.removeListener(_onSettingsChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Трекер водного баланса',
      theme: _settingsRepository.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}