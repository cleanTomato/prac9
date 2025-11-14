import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/settings/domain/services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService _settingsService = serviceLocator<SettingsService>();
  final TextEditingController _goalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _goalController.text = _settingsService.dailyGoal.toString();
    _settingsService.addListener(_onSettingsChanged);
  }

  void _onSettingsChanged() => setState(() {});

  void _updateDailyGoal() {
    final newGoal = int.tryParse(_goalController.text) ?? 2000;
    _settingsService.updateDailyGoal(newGoal);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Дневная цель обновлена: $newGoal мл'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _resetToDefault() {
    _settingsService.updateDailyGoal(2000);
    _goalController.text = '2000';
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Настройки сброшены к значениям по умолчанию'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _goalController.dispose();
    _settingsService.removeListener(_onSettingsChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: _resetToDefault,
            tooltip: 'Сбросить настройки',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDailyGoalSection(),
          const SizedBox(height: 24),
          _buildAppearanceSection(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDailyGoalSection() {
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
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Дневная цель',
                hintText: 'Введите количество в мл',
                border: OutlineInputBorder(),
                suffixText: 'мл',
                prefixIcon: Icon(Icons.flag),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _updateDailyGoal,
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

  Widget _buildAppearanceSection() {
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
              value: _settingsService.isDarkMode,
              onChanged: (value) => _settingsService.toggleTheme(),
              secondary: const Icon(Icons.dark_mode),
            ),
          ],
        ),
      ),
    );
  }
}