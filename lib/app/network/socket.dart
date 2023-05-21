// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../store/global.dart';
import '../env/config.dart';

class FireduinoSocket {
  /// The host of the socket server
  // static const String _host = kReleaseMode ? socketServerApi : 'http://192.168.1.145:5000';
  static const String _host = socketServerApi;
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
      debugPrint('Already connected to socket server at $_host');
      return;
    }

    // If token is null
    if (Global.token == null) {
      // Log that we are not connected
      debugPrint('Login token is null. Not connecting to socket server at $_host');
      return;
    }

    // Log that we are connecting
    debugPrint('Connecting to socket server at $_host');

    /// Connect to the socket server with the namespace (Specific to the establishment)
    socket = io("$_host/estb${Global.user.eid}", <String, dynamic>{
      'transports': ['websocket'],
    });

    /// Listen for the connection event
    socket!.on("connect", (data) {
      // Log that we are connected
      debugPrint('Connected to socket server at $_host');
      // Emit the platform information
      socket!.emit('mobile', Global.deviceId);
      // Emit get online fireduino devices
      getOnlineFireduinos();
    });

    /// Listen for the disconnect event
    socket!.on("disconnect", (data) {
      // Log that we are disconnected
      debugPrint('Disconnected from socket server at $_host');
    });

    /// Listen for `get_online_fireduinos` event
    /// This event is emitted when the socket server requests for online fireduino devices
    socket!.on("get_online_fireduinos", (data) {
      // Log that we are getting online fireduino devices
      debugPrint('get_online_fireduinos: $data');
      // Set the online fireduino devices
      setOnlineFireduinos(data);
    });

    /// Listen for `fireduino_connect` event
    /// This event is emitted when a fireduino device is online or not
    socket!.on('fireduino_connect', (data) {
      // Log that a fireduino device is connected
      debugPrint('fireduino_connect: $data');
      // Set the online fireduino devices
      setOnlineFireduinos(data);
    });

    /// Listen for `fireduino_disconnect` event
    /// This event is emitted when a fireduino device is disconnected
    socket!.on('fireduino_disconnect', (data) {
      // Log that a fireduino device has been disconnected
      debugPrint('fireduino_disconnect: $data');
      // Set the online fireduino devices
      setOnlineFireduinos(data);
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

  /// Extinguish fireduino device
  void extinguish(String sid, int state) {
    // Ensure that the socket is connected
    if (socket == null || !socket!.connected) {
      // Log that we are not connected
      debugPrint('Not connected to socket server at $_host');
      return;
    }

    print("Extinguishing fireduino device with SID: $sid");

    // Emit the fireduino-extinguish event
    socket!.emit("fireduino_extinguish", {
      "sid": sid,
      "state": state,
    });
  }

  /// Check fireduino device status
  void checkFireduino(String mac, Function callback, { bool isExoduino = false }) {
    // Ensure that the socket is connected
    if (socket == null || !socket!.connected) {
      // Log that we are not connected
      debugPrint('Not connected to socket server at $_host');
      callback(null);
      return;
    }

    debugPrint("Checking fireduino device with MAC Address: $mac");

    // Event name
    String eventName = "fireduino_check";

    // If is exoduino
    if (isExoduino) {
      // Set the event name
      eventName = "exoduino_check";
    }

    // Off the fireduino-check event
    socket!.off(eventName);
    // Emit the fireduino-check event
    socket!.emit(eventName, mac);
    // Listen for the fireduino-check event
    socket!.on(eventName, (data) {
      // Call the callback function
      callback(data);
    });
  }  

  void getOnlineFireduinos() {
    if (socket != null) {
      socket!.emit('get_online_fireduinos');
    }
  }

  void addFireduino(String socketId, int establishmentId) {
    if (socket != null) {
      socket!.emit('add_fireduino', {
        'sid': socketId,
        'eid': establishmentId,
      });
    }
  }

  /// Set online fireduino devices
  void setOnlineFireduinos(List<dynamic> data) {
    // List of devices
    List<Map<String, dynamic>> devices = [];

    // Convert List<dynamic> data into List<Map<String, dynamic>>
    for (final item in data) {
      devices.add(item);
    }

    // Populate the online fireduino devices
    Global.onlineFireduinos.value = devices;
    // Update list
    Global.onlineFireduinos.refresh();
  }
}