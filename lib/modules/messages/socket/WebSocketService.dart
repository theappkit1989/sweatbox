import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../services/api/api_endpoint.dart';


class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  late IO.Socket socket;

  factory WebSocketService() {
    return _instance;
  }

  WebSocketService._internal() {
    _initSocket();
  }

  void _initSocket() {
    socket = IO.io(ApiEndpoint.socket, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      print('Connected to socket server');
    });

    socket.onDisconnect((_) => print('Disconnected from socket server'));
    socket.onConnectError((err) => print('Connection Error: $err'));
    socket.onError((err) => print('Error: $err'));

    socket.connect();
  }

  void emitEvent(String event, dynamic data) {
    socket.emit(event, data);
  }

  void onEvent(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void disconnect() {
    socket.disconnect();
  }
}
