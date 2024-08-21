import 'package:flutter/material.dart';

import 'game_controls.dart';

class Joystick extends StatefulWidget {
  final Function(Direction) onDirectionChanged;

  const Joystick({super.key, required this.onDirectionChanged});

  @override
  State<Joystick> createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  Offset _startPosition = Offset.zero;
  Offset _currentPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          _startPosition = details.localPosition;
          _currentPosition = _startPosition;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _currentPosition = details.localPosition;
        });

        final offset = _currentPosition - _startPosition;
        final direction = offset.dx < -10
            ? Direction.left
            : offset.dx > 10
                ? Direction.right
                : Direction.none;

        widget.onDirectionChanged(direction);
      },
      onPanEnd: (details) {
        setState(() {
          _currentPosition = _startPosition;
        });

        widget.onDirectionChanged(Direction.none);
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.5),
        ),
        child: Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent,
            ),
            child: Center(
              child: Transform.translate(
                offset: _currentPosition - _startPosition,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
