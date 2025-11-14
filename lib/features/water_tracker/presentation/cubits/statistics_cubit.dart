import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/water_tracker/domain/repositories/water_repository.dart';
import 'package:prac9/features/settings/domain/repositories/settings_repository.dart';
import 'package:prac9/features/water_tracker/data/models/water_intake.dart';

// Состояния
abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final List<WaterIntake> intakes;
  final int totalIntake;
  final int dailyGoal;
  final double progress;
  final Map<String, int> drinkStats;

  StatisticsLoaded({
    required this.intakes,
    required this.totalIntake,
    required this.dailyGoal,
    required this.progress,
    required this.drinkStats,
  });
}

// Cubit
class StatisticsCubit extends Cubit<StatisticsState> {
  final WaterRepository _waterRepository = serviceLocator<WaterRepository>();
  final SettingsRepository _settingsRepository = serviceLocator<SettingsRepository>();

  StatisticsCubit() : super(StatisticsInitial()) {
    _waterRepository.addListener(_onDataChanged);
    _settingsRepository.addListener(_onDataChanged);
    _loadData();
  }

  void _loadData() {
    final intakes = _waterRepository.intakes;
    final totalIntake = _waterRepository.totalIntake;
    final dailyGoal = _settingsRepository.dailyGoal; // Актуальная цель из настроек
    final progress = _waterRepository.getProgress(dailyGoal);
    final drinkStats = _calculateDrinkStats(intakes);

    emit(StatisticsLoaded(
      intakes: intakes,
      totalIntake: totalIntake,
      dailyGoal: dailyGoal,
      progress: progress,
      drinkStats: drinkStats,
    ));
  }

  Map<String, int> _calculateDrinkStats(List<WaterIntake> intakes) {
    final stats = <String, int>{};
    for (final intake in intakes) {
      stats[intake.drinkType] = (stats[intake.drinkType] ?? 0) + intake.volume;
    }
    return stats;
  }

  void _onDataChanged() {
    _loadData();
  }

  @override
  Future<void> close() {
    _waterRepository.removeListener(_onDataChanged);
    _settingsRepository.removeListener(_onDataChanged);
    return super.close();
  }
}