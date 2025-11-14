import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/water_tracker/data/models/water_intake.dart';
import 'package:prac9/features/water_tracker/presentation/state/water_tracker_state.dart';
import 'package:prac9/features/water_tracker/presentation/widgets/intake_list_view.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Получаем состояние приложения через GetIt
  final WaterTrackerState _appState = serviceLocator<WaterTrackerState>();

  @override
  void initState() {
    super.initState();
    _appState.addListener(_onStateChanged);
  }

  void _onStateChanged() => setState(() {});

  @override
  void dispose() {
    _appState.removeListener(_onStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Сортируем записи по времени (новые сверху)
    final sortedIntakes = List<WaterIntake>.from(_appState.intakes)
      ..sort((a, b) => b.time.compareTo(a.time));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('История записей'),
      ),
      body: IntakeListView(
        intakes: sortedIntakes,
        onDelete: _appState.deleteIntake,
      ),
    );
  }
}