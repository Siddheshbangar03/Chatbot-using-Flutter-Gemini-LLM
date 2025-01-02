import 'dart:async';
import 'dart:convert';
import 'package:web_socket_client/web_socket_client.dart';

class ChatAppService {
  static final _instance = ChatAppService._internal();
  WebSocket? _socket;

  factory ChatAppService() => _instance;

  ChatAppService._internal();
  final _searchResultController = StreamController<Map<String, dynamic>>();
  // final _contentController = StreamController<Map<String, dynamic>>();
  StreamController<Map<String, dynamic>>? _contentController;

  Stream<Map<String, dynamic>> get searchResultStream =>
      _searchResultController.stream;
  // Stream<Map<String, dynamic>> get contentStream => _contentController.stream;

  Stream<Map<String, dynamic>> get contentStream {
    _contentController ??= StreamController<Map<String, dynamic>>.broadcast();
    return _contentController!.stream;
  }

  void resetStream() {
    _contentController?.close();
    _contentController = StreamController<Map<String, dynamic>>.broadcast();
  }

  void connect() {
    _socket = WebSocket(Uri.parse("ws://localhost:8000/ws/chat"));

    _socket!.messages.listen((message) {
      final data = json.decode(message);
      if (data['type'] == 'content') {
        _contentController?.add(data);
      } else if (data['type'] == 'content') {
        _contentController?.add(data);
      }
    });
  }

  void chat(String query) {
    resetStream();
    print(query);
    print(_socket);
    _socket!.send(json.encode({'query': query}));
  }

  void dispose() {
    _contentController?.close();
    _contentController = null;
  }
}
