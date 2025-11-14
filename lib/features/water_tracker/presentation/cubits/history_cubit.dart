import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/water_tracker/domain/repositories/water_repository.dart';
import 'package:prac9/features/water_tracker/data/models/water_intake.dart';

// Состояния
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<WaterIntake> intakes;

  HistoryLoaded(this.intakes);
}

// Cubit
class HistoryCubit extends Cubit<HistoryState> {
  final WaterRepository _repository = serviceLocator<WaterRepository>();

  HistoryCubit() : super(HistoryInitial()) {
    _repository.addListener(_onRepositoryChanged);
    _loadData();
  }

  void _loadData() {
    // Сортируем по времени (новые сверху)
    final sortedIntakes = List<WaterIntake>.from(_repository.intakes)
      ..sort((a, b) => b.time.compareTo(a.time));

    emit(HistoryLoaded(sortedIntakes));
  }

  void _onRepositoryChanged() {
    _loadData();
  }

  void deleteIntake(String id) {
    _repository.deleteIntake(id);
  }

  @override
  Future<void> close() {
    _repository.removeListener(_onRepositoryChanged);
    return super.close();
  }
}