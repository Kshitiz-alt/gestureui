import 'package:flutter/material.dart';

class ConnectionPanel extends StatelessWidget {
  final TextEditingController controller;
  final bool connected;
  final VoidCallback onConnect;

  const ConnectionPanel({
    super.key,
    required this.controller,
    required this.connected,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Laptop IP",
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: const Color(0xff151515),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onConnect,
          child: Text(connected ? "Connected" : "Connect"),
        ),
      ],
    );
  }
}