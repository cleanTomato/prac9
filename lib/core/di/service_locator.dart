import 'package:get_it/get_it.dart';
import 'package:prac9/features/water_tracker/domain/repositories/water_repository.dart';
import 'package:prac9/features/settings/domain/repositories/settings_repository.dart';
import 'package:prac9/core/services/ui_logic_service.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<WaterRepository>(() => WaterRepository());
  serviceLocator.registerLazySingleton<SettingsRepository>(() => SettingsRepository());
  serviceLocator.registerLazySingleton<UILogicService>(() => UILogicService());
}