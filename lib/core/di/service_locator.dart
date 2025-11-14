import 'package:get_it/get_it.dart';
import 'package:prac9/features/settings/domain/services/settings_service.dart';
import 'package:prac9/features/water_tracker/presentation/state/water_tracker_state.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // Сервис настроек - управление темой и пользовательскими настройками
  serviceLocator.registerLazySingleton<SettingsService>(() => SettingsService());

  // Состояние трекера воды - бизнес-логика и данные о потреблении воды
  serviceLocator.registerLazySingleton<WaterTrackerState>(() => WaterTrackerState());

  // Все сервисы используют один экземпляр во всем приложении
  // Это обеспечивает согласованность данных между экранами
}