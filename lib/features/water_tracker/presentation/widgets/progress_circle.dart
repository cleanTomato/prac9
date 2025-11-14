import 'package:flutter/material.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/core/services/ui_logic_service.dart';

class ProgressCircle extends StatelessWidget {
  final double progress;
  final int current;
  final int goal;

  const ProgressCircle({
    super.key,
    required this.progress,
    required this.current,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final UILogicService _uiLogicService = serviceLocator<UILogicService>();
    final progressColor = _uiLogicService.getProgressColor(progress);

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            strokeWidth: 12,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$current мл',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'из $goal мл',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}