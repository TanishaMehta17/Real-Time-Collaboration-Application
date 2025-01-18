import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:real_time_collaboration_application/global_variable.dart';

class SocketService {
  late IO.Socket socket;
  
  // Private constructor
  SocketService._privateConstructor();

  // Singleton instance
  static final SocketService _instance = SocketService._privateConstructor();

  // Factory constructor to return the same instance
  factory SocketService() {
    return _instance;
  }

  void initSocket() {
    socket = IO.io(
      uri, // Replace with your backend URL
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    socket.connect();
  }

  void joinRoom(String roomId) {
    print(roomId);
    socket.emit('joinTask', roomId);
  }
   void joinTeam(String roomId) {
    print(roomId);
    socket.emit('joinTeam', roomId);
  }

  void leaveRoom(String roomId) {
    print(roomId);
    socket.emit('leaveTeam', roomId);
  }
// chnages done
    void leaveTask(String taskId, String userId) {
      print('Task ID: $taskId, User ID: $userId');
      socket.emit('leaveTask', { taskId, userId});
    }

  void onEvent(String event, Function(dynamic) callback) {
    print(event);
    print(callback);
    socket.on(event, callback);
  }

  void offEvent(String event) {
    print(event);
    socket.off(event);
  }

  void emitEvent(String event, dynamic data) {
    print(event);
    print(data);
    socket.emit(event, data);
  }
}