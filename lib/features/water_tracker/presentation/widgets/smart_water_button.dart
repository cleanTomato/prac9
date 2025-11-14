import 'package:flutter/material.dart';

class SmartWaterButton extends StatefulWidget {
  final int currentVolume;
  final int dailyGoal;
  final VoidCallback onPressed;

  const SmartWaterButton({
    super.key,
    required this.currentVolume,
    required this.dailyGoal,
    required this.onPressed,
  });

  @override
  State<SmartWaterButton> createState() => _SmartWaterButtonState();
}

class _SmartWaterButtonState extends State<SmartWaterButton> {
  bool _isPressed = false;

  String _getButtonText() {
    final progress = widget.dailyGoal > 0
        ? widget.currentVolume / widget.dailyGoal
        : 0;

    if (progress >= 1.0) return 'Отлично!';
    if (progress >= 0.8) return 'Почти у цели!';
    if (progress >= 0.5) return 'Так держать!';
    return 'Добавить жидкость';
  }

  Color _getButtonColor() {
    final progress = widget.dailyGoal > 0
        ? widget.currentVolume / widget.dailyGoal
        : 0;

    if (progress >= 1.0) return Colors.green;
    if (progress >= 0.7) return Colors.blue;
    if (progress >= 0.4) return Colors.lightBlue;
    return Colors.blueAccent;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: _getButtonColor(),
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isPressed
              ? []
              : [
            BoxShadow(
              color: _getButtonColor().withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            _getButtonText(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}