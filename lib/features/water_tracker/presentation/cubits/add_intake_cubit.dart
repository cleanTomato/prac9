import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/water_tracker/domain/repositories/water_repository.dart';
import 'package:prac9/features/water_tracker/data/models/water_intake.dart';

// Состояния
abstract class AddIntakeState {}

class AddIntakeInitial extends AddIntakeState {
  final String volumeText;
  final String selectedDrinkType;
  final bool isValidVolume;

  AddIntakeInitial({
    this.volumeText = '',
    this.selectedDrinkType = 'water',
    this.isValidVolume = false,
  });
}

// Cubit
class AddIntakeCubit extends Cubit<AddIntakeState> {
  final WaterRepository _repository = serviceLocator<WaterRepository>();

  AddIntakeCubit() : super(AddIntakeInitial());

  void updateVolumeText(String text) {
    final currentState = state as AddIntakeInitial;
    final volume = int.tryParse(text);
    final isValid = volume != null && volume > 0;

    emit(AddIntakeInitial(
      volumeText: text,
      selectedDrinkType: currentState.selectedDrinkType,
      isValidVolume: isValid,
    ));
  }

  void updateDrinkType(String drinkType) {
    final currentState = state as AddIntakeInitial;
    emit(AddIntakeInitial(
      volumeText: currentState.volumeText,
      selectedDrinkType: drinkType,
      isValidVolume: currentState.isValidVolume,
    ));
  }

  void submit() {
    final currentState = state as AddIntakeInitial;
    final volume = int.tryParse(currentState.volumeText);

    if (volume != null && volume > 0) {
      final newIntake = WaterIntake(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        volume: volume,
        drinkType: currentState.selectedDrinkType,
        time: DateTime.now(),
      );

      _repository.addIntake(newIntake);
    }
  }

  void reset() {
    emit(AddIntakeInitial());
  }
}