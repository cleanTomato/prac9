import 'package:flutter/material.dart';

class DrinkType {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final double coefficient;

  const DrinkType({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.coefficient,
  });
}

class DrinkTypes {
  static const List<DrinkType> allTypes = [
    DrinkType(
      id: 'water',
      name: 'Вода',
      icon: Icons.water_drop,
      color: Colors.blue,
      coefficient: 1.0,
    ),
    DrinkType(
      id: 'herbal_tea',
      name: 'Травяной чай',
      icon: Icons.eco,
      color: Colors.green,
      coefficient: 0.95,
    ),
    DrinkType(
      id: 'green_tea',
      name: 'Зеленый чай',
      icon: Icons.emoji_food_beverage,
      color: Colors.green,
      coefficient: 0.95,
    ),
    DrinkType(
      id: 'black_tea',
      name: 'Черный чай',
      icon: Icons.emoji_food_beverage,
      color: Colors.brown,
      coefficient: 0.95,
    ),
    DrinkType(
      id: 'coffee',
      name: 'Кофе',
      icon: Icons.coffee,
      color: Colors.brown,
      coefficient: 0.6,
    ),
    DrinkType(
      id: 'juice',
      name: 'Сок',
      icon: Icons.local_drink,
      color: Colors.orange,
      coefficient: 0.8,
    ),
    DrinkType(
      id: 'soda',
      name: 'Газировка',
      icon: Icons.liquor,
      color: Colors.red,
      coefficient: 0.7,
    ),
    DrinkType(
      id: 'sports_drink',
      name: 'Изотоник',
      icon: Icons.fitness_center,
      color: Colors.blue,
      coefficient: 0.9,
    ),
    DrinkType(
      id: 'milk',
      name: 'Молоко',
      icon: Icons.local_cafe,
      color: Colors.grey,
      coefficient: 0.8,
    ),
  ];
}