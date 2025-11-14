import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/settings/domain/repositories/settings_repository.dart';

// Состояния
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final int dailyGoal;
  final bool isDarkMode;
  final String goalText;
  final bool isGoalValid;

  SettingsLoaded({
    required this.dailyGoal,
    required this.isDarkMode,
    required this.goalText,
    required this.isGoalValid,
  });
}

// Cubit
class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository = serviceLocator<SettingsRepository>();

  SettingsCubit() : super(SettingsInitial()) {
    _repository.addListener(_onRepositoryChanged);
    _loadData();
  }

  void _loadData() {
    emit(SettingsLoaded(
      dailyGoal: _repository.dailyGoal,
      isDarkMode: _repository.isDarkMode,
      goalText: _repository.dailyGoal.toString(),
      isGoalValid: true,
    ));
  }

  void _onRepositoryChanged() {
    _loadData();
  }

  void updateGoalText(String text) {
    final currentState = state as SettingsLoaded;
    final goal = int.tryParse(text);
    final isValid = goal != null && goal > 0;

    emit(SettingsLoaded(
      dailyGoal: currentState.dailyGoal,
      isDarkMode: currentState.isDarkMode,
      goalText: text,
      isGoalValid: isValid,
    ));
  }

  void submitGoal() {
    final currentState = state as SettingsLoaded;
    final goal = int.tryParse(currentState.goalText);

    if (goal != null && goal > 0) {
      _repository.updateDailyGoal(goal);
    }
  }

  void toggleDarkMode() {
    _repository.toggleDarkMode();
  }

  void resetToDefault() {
    _repository.resetToDefault();
    _loadData();
  }

  bool get isDarkMode => _repository.isDarkMode;

  @override
  Future<void> close() {
    _repository.removeListener(_onRepositoryChanged);
    return super.close();
  }
}