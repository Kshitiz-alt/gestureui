import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class MouseSocketService {
  WebSocketChannel? _channel;

  bool get isConnected => _channel != null;

  void connect(String ip, {
    required Function(String message) onMessage,
    required Function(Object error) onError,
    required Function() onDone,
  }) {
    _channel = WebSocketChannel.connect(
      Uri.parse("ws://$ip:8080"),
    );

    _channel!.stream.listen(
      (event) => onMessage(event.toString()),
      onError: onError,
      onDone: onDone,
    );
  }

  void send(Map<String, dynamic> data) {
    if (_channel == null) return;
    _channel!.sink.add(jsonEncode(data));
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }
}