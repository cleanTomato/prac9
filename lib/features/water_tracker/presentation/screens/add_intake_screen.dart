import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/features/water_tracker/presentation/state/water_tracker_state.dart';
import 'package:prac9/core/constants/drink_types.dart';
import 'package:prac9/features/water_tracker/data/models/water_intake.dart';

class AddIntakeScreen extends StatefulWidget {
  const AddIntakeScreen({super.key});

  @override
  State<AddIntakeScreen> createState() => _AddIntakeScreenState();
}

class _AddIntakeScreenState extends State<AddIntakeScreen> {
  final TextEditingController _volumeController = TextEditingController();
  String _selectedDrinkType = DrinkTypes.allTypes.first.id;
  bool _isValidVolume = false;

  // Получаем состояние приложения через GetIt
  final WaterTrackerState _appState = serviceLocator<WaterTrackerState>();

  void _submit() {
    final volume = int.tryParse(_volumeController.text);

    if (volume != null && volume > 0) {
      final newIntake = WaterIntake(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        volume: volume,
        drinkType: _selectedDrinkType,
        time: DateTime.now(),
      );
      // Добавляем запись через состояние приложения
      _appState.addIntake(newIntake);
      context.pop();
    } else {
      _showErrorDialog('Пожалуйста, введите корректное количество мл (больше 0)');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _validateVolume(String value) {
    final volume = int.tryParse(value);
    setState(() {
      _isValidVolume = volume != null && volume > 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _volumeController.addListener(() => _validateVolume(_volumeController.text));
  }

  @override
  void dispose() {
    _volumeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить запись'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Количество мл:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _volumeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Объем в миллилитрах',
                hintText: 'Например: 250',
                border: const OutlineInputBorder(),
                suffixText: 'мл',
                errorText: _volumeController.text.isNotEmpty && !_isValidVolume
                    ? 'Введите число больше 0'
                    : null,
              ),
              onChanged: _validateVolume,
            ),
            const SizedBox(height: 8),
            if (_isValidVolume)
              Text(
                'Вы ввели: ${_volumeController.text} мл',
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

            const SizedBox(height: 32),

            const Text(
              'Тип напитка:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: DrinkTypes.allTypes.map((drink) {
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(drink.icon, size: 18, color: drink.color),
                      const SizedBox(width: 6),
                      Text(drink.name),
                    ],
                  ),
                  selected: _selectedDrinkType == drink.id,
                  onSelected: (selected) {
                    setState(() {
                      _selectedDrinkType = drink.id;
                    });
                  },
                );
              }).toList(),
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isValidVolume ? _submit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      disabledBackgroundColor: Colors.grey[400],
                    ),
                    child: const Text(
                      'Добавить',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Отмена',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}