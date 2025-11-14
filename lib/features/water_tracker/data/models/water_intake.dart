import 'package:prac9/core/constants/drink_types.dart';

class WaterIntake {
  final String id;
  final int volume;
  final String drinkType;
  final DateTime time;

  const WaterIntake({
    required this.id,
    required this.volume,
    required this.drinkType,
    required this.time,
  });

  /// Рассчитывает эффективный объем с учетом коэффициента напитка
  int get effectiveVolume {
    final drink = DrinkTypes.allTypes.firstWhere(
          (d) => d.id == drinkType,
      orElse: () => DrinkTypes.allTypes.first,
    );
    return (volume * drink.coefficient).round();
  }

  WaterIntake copyWith({
    String? id,
    int? volume,
    String? drinkType,
    DateTime? time,
  }) {
    return WaterIntake(
      id: id ?? this.id,
      volume: volume ?? this.volume,
      drinkType: drinkType ?? this.drinkType,
      time: time ?? this.time,
    );
  }
}