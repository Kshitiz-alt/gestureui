import 'package:flutter/material.dart';
import '../services/mouse_service.dart';
import '../widgets/connection.dart';
import '../widgets/touchpad.dart';
import '../widgets/mouse_buttons.dart';

class TouchpadScreen extends StatefulWidget {
  const TouchpadScreen({super.key});

  @override
  State<TouchpadScreen> createState() => _TouchpadScreenState();
}

class _TouchpadScreenState extends State<TouchpadScreen> {
  final ipController = TextEditingController();
  final mouseService = MouseSocketService();

  bool connected = false;

  void connect() {
    final ip = ipController.text.trim();

    mouseService.connect(
      ip,
      onMessage: (message) {
        setState(() {
          connected = true;
        });
      },
      onError: (error) {
        setState(() {
          connected = false;
        });
      },
      onDone: () {
        setState(() {
          connected = false;
        });
      },
    );
  }

  void send(Map<String, dynamic> data) {
    mouseService.send(data);
  }

  @override
  void dispose() {
    ipController.dispose();
    mouseService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Gesture Mouse"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ConnectionPanel(
              controller: ipController,
              connected: connected,
              onConnect: connect,
            ),
            const SizedBox(height: 14),
            Expanded(
              child: TouchpadArea(
                onSend: send,
              ),
            ),
            const SizedBox(height: 14),
            MouseButtons(
              onSend: send,
            ),
          ],
        ),
      ),
    );
  }
}