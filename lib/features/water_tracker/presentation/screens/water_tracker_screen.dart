import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/water_tracker/presentation/state/water_tracker_state.dart';
import 'package:prac9/features/settings/domain/services/settings_service.dart';
import 'package:prac9/features/water_tracker/presentation/widgets/intake_list_view.dart';
import 'package:prac9/features/water_tracker/presentation/widgets/smart_water_button.dart';
import 'package:prac9/features/water_tracker/presentation/widgets/water_level_indicator.dart';
import 'package:prac9/features/water_tracker/presentation/widgets/progress_circle.dart';

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  // Получаем зависимости через GetIt
  final WaterTrackerState _appState = serviceLocator<WaterTrackerState>();
  final SettingsService _settingsService = serviceLocator<SettingsService>();

  @override
  void initState() {
    super.initState();
    // Подписываемся на изменения состояния для перерисовки UI
    _appState.addListener(_onStateChanged);
    //Подписка на изменение настроек
    _settingsService.addListener(_onStateChanged);
  }

  void _onStateChanged() => setState(() {});

  @override
  void dispose() {
    _settingsService.removeListener(_onStateChanged);
    _appState.removeListener(_onStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _appState.getProgress(_settingsService.dailyGoal);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Водный баланс'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: () => context.push('/gallery'),
            tooltip: 'Галерея напитков',
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => context.push('/statistics'),
            tooltip: 'Статистика',
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.push('/history'),
            tooltip: 'История',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
            tooltip: 'Настройки',
          ),
          IconButton(
            icon: Icon(_settingsService.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => _settingsService.toggleTheme(),
            tooltip: 'Переключить тему',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProgressCircle(
                  progress: progress,
                  current: _appState.totalIntake,
                  goal: _settingsService.dailyGoal,
                ),
                WaterLevelIndicator(progress: progress),
              ],
            ),
            const SizedBox(height: 20),
            SmartWaterButton(
              currentVolume: _appState.totalIntake,
              dailyGoal: _settingsService.dailyGoal,
              onPressed: () => context.push('/add'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: IntakeListView(
                intakes: _appState.intakes,
                onDelete: _appState.deleteIntake,
              ),
            ),
          ],
        ),
      ),
    );
  }
}