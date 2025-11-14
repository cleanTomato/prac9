import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/features/settings/presentation/cubit/settings_cubit.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _submitGoal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    cubit.submitGoal();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Дневная цель обновлена'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _resetToDefault(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    cubit.resetToDefault();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Настройки сброшены к значениям по умолчанию'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        // Можно добавить обработку специфических состояний если нужно
      },
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();

          if (state is SettingsLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Настройки'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.restart_alt),
                    onPressed: () => _resetToDefault(context),
                    tooltip: 'Сбросить настройки',
                  ),
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildDailyGoalSection(context, state, cubit),
                  const SizedBox(height: 24),
                  _buildAppearanceSection(context, state, cubit),
                ],
              ),
            );
          }

          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildDailyGoalSection(BuildContext context, SettingsLoaded state, SettingsCubit cubit) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Дневная цель',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Установите целевое количество воды в миллилитрах, '
                  'которое вы планируете выпивать за день',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: cubit.updateGoalText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Дневная цель',
                hintText: 'Введите количество в мл',
                border: const OutlineInputBorder(),
                suffixText: 'мл',
                prefixIcon: const Icon(Icons.flag),
                errorText: state.goalText.isNotEmpty && !state.isGoalValid
                    ? 'Введите число больше 0'
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: state.isGoalValid ? () => _submitGoal(context) : null,
                icon: const Icon(Icons.save),
                label: const Text('Сохранить цель'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceSection(BuildContext context, SettingsLoaded state, SettingsCubit cubit) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Внешний вид',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Тёмная тема'),
              subtitle: const Text('Переключение между светлой и тёмной темой'),
              value: state.isDarkMode,
              onChanged: (value) => cubit.toggleDarkMode(),
              secondary: const Icon(Icons.dark_mode),
            ),
          ],
        ),
      ),
    );
  }
}