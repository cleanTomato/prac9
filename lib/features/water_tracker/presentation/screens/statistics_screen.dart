import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/water_tracker/presentation/state/water_tracker_state.dart';
import 'package:prac9/features/settings/domain/services/settings_service.dart';
import 'package:prac9/core/constants/drink_types.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // Получаем зависимости через GetIt
  final WaterTrackerState _appState = serviceLocator<WaterTrackerState>();
  final SettingsService _settingsService = serviceLocator<SettingsService>();

  @override
  void initState() {
    super.initState();
    _appState.addListener(_onStateChanged);
  }

  void _onStateChanged() => setState(() {});

  @override
  void dispose() {
    _appState.removeListener(_onStateChanged);
    _settingsService.removeListener(_onStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _appState.getProgress(_settingsService.dailyGoal);

    // Собираем статистику по типам напитков
    final drinkStats = <String, int>{};
    for (final intake in _appState.intakes) {
      drinkStats[intake.drinkType] = (drinkStats[intake.drinkType] ?? 0) + intake.volume;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Статистика'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Общая статистика',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Выпито всего: ${_appState.totalIntake} мл'),
                    Text('Дневная цель: ${_settingsService.dailyGoal} мл'),
                    Text('Прогресс: ${(progress * 100).toStringAsFixed(1)}%'),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Статистика по напиткам:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: drinkStats.entries.map((entry) {
                  final drink = DrinkTypes.allTypes.firstWhere(
                        (d) => d.id == entry.key,
                    orElse: () => DrinkTypes.allTypes.first,
                  );
                  return ListTile(
                    leading: Icon(drink.icon, color: drink.color),
                    title: Text(drink.name),
                    trailing: Text('${entry.value} мл'),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}