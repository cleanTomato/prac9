import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/water_tracker/domain/repositories/water_repository.dart';
import 'package:prac9/features/settings/domain/repositories/settings_repository.dart';
import 'package:prac9/features/water_tracker/data/models/water_intake.dart';

// Состояния
abstract class WaterTrackerState {}

class WaterTrackerInitial extends WaterTrackerState {}

class WaterTrackerLoaded extends WaterTrackerState {
  final List<WaterIntake> intakes;
  final int totalIntake;
  final double progress;
  final int dailyGoal;

  WaterTrackerLoaded({
    required this.intakes,
    required this.totalIntake,
    required this.progress,
    required this.dailyGoal,
  });
}

class WaterTrackerError extends WaterTrackerState {
  final String message;
  WaterTrackerError(this.message);
}

// Cubit
class WaterTrackerCubit extends Cubit<WaterTrackerState> {
  final WaterRepository _waterRepository = serviceLocator<WaterRepository>();
  final SettingsRepository _settingsRepository = serviceLocator<SettingsRepository>();

  WaterTrackerCubit() : super(WaterTrackerInitial()) {
    _waterRepository.addListener(_onRepositoryChanged);
    _settingsRepository.addListener(_onRepositoryChanged);
    _loadData();
  }

  void _loadData() {
    final intakes = _waterRepository.intakes;
    final totalIntake = _waterRepository.totalIntake;
    final dailyGoal = _settingsRepository.dailyGoal;
    final progress = _waterRepository.getProgress(dailyGoal);

    emit(WaterTrackerLoaded(
      intakes: intakes,
      totalIntake: totalIntake,
      progress: progress,
      dailyGoal: dailyGoal,
    ));
  }

  void _onRepositoryChanged() {
    _loadData();
  }

  void addIntake(WaterIntake intake) {
    _waterRepository.addIntake(intake);
  }

  void deleteIntake(String id) {
    _waterRepository.deleteIntake(id);
  }

  @override
  Future<void> close() {
    _waterRepository.removeListener(_onRepositoryChanged);
    _settingsRepository.removeListener(_onRepositoryChanged);
    return super.close();
  }
}