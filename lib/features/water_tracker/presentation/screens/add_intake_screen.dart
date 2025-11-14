import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/features/water_tracker/presentation/cubits/add_intake_cubit.dart';
import 'package:prac9/core/constants/drink_types.dart';

class AddIntakeScreen extends StatelessWidget {
  const AddIntakeScreen({super.key});

  void _submit(BuildContext context) {
    final cubit = context.read<AddIntakeCubit>();
    cubit.submit();
    context.pop();
  }

  void _showErrorDialog(BuildContext context, String message) {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddIntakeCubit, AddIntakeState>(
      builder: (context, state) {
        final cubit = context.read<AddIntakeCubit>();

        if (state is AddIntakeInitial) {
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
                    onChanged: cubit.updateVolumeText,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Объем в миллилитрах',
                      hintText: 'Например: 250',
                      border: const OutlineInputBorder(),
                      suffixText: 'мл',
                      errorText: state.volumeText.isNotEmpty && !state.isValidVolume
                          ? 'Введите число больше 0'
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (state.isValidVolume)
                    Text(
                      'Вы ввели: ${state.volumeText} мл',
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
                        selected: state.selectedDrinkType == drink.id,
                        onSelected: (selected) => cubit.updateDrinkType(drink.id),
                      );
                    }).toList(),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: state.isValidVolume ? () => _submit(context) : null,
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
                          onPressed: () {
                            cubit.reset();
                            context.pop();
                          },
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

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}