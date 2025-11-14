import 'package:flutter/material.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/core/services/ui_logic_service.dart';

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
  final UILogicService _uiLogicService = serviceLocator<UILogicService>();

  @override
  Widget build(BuildContext context) {
    final buttonText = _uiLogicService.getButtonText(widget.currentVolume, widget.dailyGoal);
    final buttonColor = _uiLogicService.getButtonColor(widget.currentVolume, widget.dailyGoal);

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
          color: buttonColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isPressed
              ? []
              : [
            BoxShadow(
              color: buttonColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttonText,
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