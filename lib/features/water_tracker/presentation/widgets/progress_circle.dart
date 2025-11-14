import 'package:flutter/material.dart';

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
            valueColor: AlwaysStoppedAnimation<Color>(
              _getProgressColor(progress),
            ),
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

  Color _getProgressColor(double progress) {
    if (progress >= 1.0) return Colors.green;
    if (progress >= 0.7) return Colors.blue;
    if (progress >= 0.4) return Colors.lightBlue;
    return Colors.blueAccent;
  }
}