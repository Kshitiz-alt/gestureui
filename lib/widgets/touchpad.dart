import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/mouse_model.dart';

class TouchpadArea extends StatefulWidget {
  final Function(Map<String, dynamic>) onSend;

  const TouchpadArea({super.key, required this.onSend});

  @override
  State<TouchpadArea> createState() => _TouchpadAreaState();
}

class _TouchpadAreaState extends State<TouchpadArea> {
  int activePointers = 0;
  double sensitivity = 4;
  double scrollSensitivity = 1.2;
  double lastFocalY = 0;

  void send(Map<String, dynamic> data) {
    widget.onSend(data);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => activePointers++,
      onPointerUp: (_) {
        activePointers--;
        if (activePointers < 0) activePointers = 0;
      },
      onPointerCancel: (_) => activePointers = 0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,

        onTap: () {
          HapticFeedback.lightImpact();
          send(MouseCommand.leftClick());
        },

        onDoubleTap: () {
          HapticFeedback.mediumImpact();
          send(MouseCommand.leftClick());

          Future.delayed(const Duration(milliseconds: 90), () {
            send(MouseCommand.leftClick());
          });
        },

        onLongPressStart: (_) {
          HapticFeedback.heavyImpact();
          send(MouseCommand.mouseDown());
        },

        onLongPressMoveUpdate: (details) {
          double dx = details.offsetFromOrigin.dx * 0.15;
          double dy = details.offsetFromOrigin.dy * 0.15;

          send(MouseCommand.move(dx.round(), dy.round()));
        },

        onLongPressEnd: (_) {
          send(MouseCommand.mouseUp());
        },

        onScaleStart: (details) {
          lastFocalY = details.focalPoint.dy;
        },

        onScaleUpdate: (details) {
          if (details.pointerCount >= 2) {
            final dy = details.focalPoint.dy - lastFocalY;

            if (dy.abs() > 1) {
              send(MouseCommand.scroll((-dy * scrollSensitivity).round()));
            }

            lastFocalY = details.focalPoint.dy;
            return;
          }

          double dx = details.focalPointDelta.dx;
          double dy = details.focalPointDelta.dy;

          double speed = dx.abs() + dy.abs();
          double multiplier = sensitivity;

          if (speed > 8) {
            multiplier *= 1.8;
          }

          if (speed > 16) {
            multiplier *= 2.5;
          }

          dx *= multiplier;
          dy *= multiplier;

          if (dx.abs() < 1 && dy.abs() < 1) return;

          dx = dx.clamp(-120, 120);
          dy = dy.clamp(-120, 120);

          send(MouseCommand.move(dx.round(), dy.round()));
        },

        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff151515),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.white12),
                ),
                child: const Center(
                  child: Text(
                    "Touchpad\nTap • Double Tap • Long Press Drag\nTwo Finger Scroll",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 19,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Text("Speed", style: TextStyle(color: Colors.white70)),
                Expanded(
                  child: Slider(
                    value: sensitivity,
                    min: 1,
                    max: 8,
                    divisions: 14,
                    label: sensitivity.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        sensitivity = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
