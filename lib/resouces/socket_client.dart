import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  static String get socketUrl {
    const overrideUrl = String.fromEnvironment('SOCKET_URL', defaultValue: '');
    if (overrideUrl.isNotEmpty) {
      return overrideUrl;
    }

    if (kIsWeb) {
      return 'https://server-production-ce2e.up.railway.app';
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'https://server-production-ce2e.up.railway.app';
    }

    return 'https://server-production-ce2e.up.railway.app';
  }

  SocketClient._internal() {
    socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket', 'polling'],
      'autoConnect': false,
      'reconnection': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 1000,
    });

    socket!.onConnect((_) {
      debugPrint('Socket.IO client connected');
    });
    socket!.onConnectError((err) {
      debugPrint('Socket.IO connect error: $err');
    });
    socket!.onError((err) {
      debugPrint('Socket.IO error: $err');
    });
    socket!.onDisconnect((reason) {
      debugPrint('Socket.IO disconnected: $reason');
    });

    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    if (_instance!.socket == null) {
      _instance = SocketClient._internal();
    }
    return _instance!;
  }
}
