import 'package:socket_io_client/socket_io_client.dart';

import 'package:fireduino/app/store/global.dart';

class FireduinoSocket {
  /// The host of the socket server
  static const String _host = 'http://192.168.1.145:5000';
  /// The socket instance
  static FireduinoSocket? _instance;
  /// The socket instance
  Socket? socket;

  /// Get the socket instance
  static FireduinoSocket get instance {
    _instance ??= FireduinoSocket();
    return _instance!;
  }

  /// Connect to the socket server
  void connect() {
    // Ensure that the socket is not already connected
    if (socket != null && socket!.connected) {
      // Log that we are already connected
      print('Already connected to socket server at $_host');
      return;
    }

    // Log that we are connecting
    print('Connecting to socket server at $_host');

    /// Connect to the socket server
    socket = io(_host, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    }).connect();

    /// Listen for the connection event
    socket!.on("connect", (data) {
      // Log that we are connected
      print('Connected to socket server at $_host');
      // Emit the platform information
      socket!.emit('mobile', Global.deviceId);
    });

    /// Listen for the disconnect event
    socket!.on("disconnect", (data) {
      // Log that we are disconnected
      print('Disconnected from socket server at $_host');
    });
  }

  /// Disconnect from the socket server
  void disconnect() {
    if (socket != null) {
      socket!.disconnect();
      socket!.off("connect");
      socket!.destroy();
    }
  }

  /// Check fireduino device status
  void checkFireduino(String serialId, Function callback) {
    // Ensure that the socket is connected
    if (socket == null || !socket!.connected) {
      // Log that we are not connected
      print('Not connected to socket server at $_host');
      callback(null);
      return;
    }

    print("Checking fireduino device with serial ID: $serialId");

    // Off the fireduino-check event
    socket!.off('fireduino-check');
    // Emit the fireduino-check event
    socket!.emit('fireduino-check', serialId);
    // Listen for the fireduino-check event
    socket!.on('fireduino-check', (data) {
      // Call the callback function
      callback(data);
    });
  }
}