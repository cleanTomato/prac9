import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:prac9/features/water_tracker/presentation/cubits/water_tracker_cubit.dart';
import 'package:prac9/features/water_tracker/presentation/widgets/intake_list_view.dart';
import 'package:prac9/features/water_tracker/presentation/widgets/smart_water_button.dart';
import 'package:prac9/features/water_tracker/presentation/widgets/water_level_indicator.dart';
import 'package:prac9/features/water_tracker/presentation/widgets/progress_circle.dart';

class WaterTrackerScreen extends StatelessWidget {
  const WaterTrackerScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterTrackerCubit, WaterTrackerState>(
      builder: (context, state) {
        final waterCubit = context.read<WaterTrackerCubit>();
        final settingsCubit = context.read<SettingsCubit>();

        if (state is WaterTrackerLoaded) {
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
                  icon: Icon(settingsCubit.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () => settingsCubit.toggleDarkMode(),
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
                        progress: state.progress,
                        current: state.totalIntake,
                        goal: state.dailyGoal,
                      ),
                      WaterLevelIndicator(progress: state.progress),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SmartWaterButton(
                    currentVolume: state.totalIntake,
                    dailyGoal: state.dailyGoal,
                    onPressed: () => context.push('/add'),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: IntakeListView(
                      intakes: state.intakes,
                      onDelete: waterCubit.deleteIntake,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}