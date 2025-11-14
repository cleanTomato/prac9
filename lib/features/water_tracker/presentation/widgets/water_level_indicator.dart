import 'package:flutter/material.dart';
import 'package:prac9/core/di/service_locator.dart';
import 'package:prac9/core/services/ui_logic_service.dart';

class WaterLevelIndicator extends StatefulWidget {
  final double progress;

  const WaterLevelIndicator({
    super.key,
    required this.progress,
  });

  @override
  State<WaterLevelIndicator> createState() => _WaterLevelIndicatorState();
}

class _WaterLevelIndicatorState extends State<WaterLevelIndicator>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;
  final UILogicService _uiLogicService = serviceLocator<UILogicService>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward();
  }

  @override
  void didUpdateWidget(WaterLevelIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _controller.reset();
      _animation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ));
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final waterColor = _uiLogicService.getWaterColor(_animation.value);

        return Container(
          width: 30,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 150 * _animation.value,
                  decoration: BoxDecoration(
                    color: waterColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}