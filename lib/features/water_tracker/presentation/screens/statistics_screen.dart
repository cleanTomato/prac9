import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/features/water_tracker/presentation/cubits/statistics_cubit.dart';
import 'package:prac9/core/constants/drink_types.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state is StatisticsLoaded) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
              title: const Text('Статистика'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Общая статистика',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text('Выпито всего: ${state.totalIntake} мл'),
                          Text('Дневная цель: ${state.dailyGoal} мл'),
                          Text('Прогресс: ${(state.progress * 100).toStringAsFixed(1)}%'),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Статистика по напиткам:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: state.drinkStats.entries.map((entry) {
                        final drink = DrinkTypes.allTypes.firstWhere(
                              (d) => d.id == entry.key,
                          orElse: () => DrinkTypes.allTypes.first,
                        );
                        return ListTile(
                          leading: Icon(drink.icon, color: drink.color),
                          title: Text(drink.name),
                          trailing: Text('${entry.value} мл'),
                        );
                      }).toList(),
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