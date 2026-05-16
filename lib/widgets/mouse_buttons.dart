import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/mouse_model.dart';

class MouseButtons extends StatelessWidget {
  final Function(Map<String, dynamic>) onSend;

  const MouseButtons({
    super.key,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xff202020),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                onSend(MouseCommand.leftClick());
              },
              child: const Center(
                child: Text(
                  "Left Click",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          Container(width: 1, color: Colors.white24),
          Expanded(
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                onSend(MouseCommand.rightClick());
              },
              child: const Center(
                child: Text(
                  "Right Click",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}