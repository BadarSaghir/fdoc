import 'package:fdoc/client/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketRepo {
  final _socketClient = SocketClient.instance.socket!;
  io.Socket get socketClient => _socketClient;

  void joinRoom(String documentId) {
    _socketClient.emit('join', documentId);
  }
}
