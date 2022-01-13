import 'package:flutter/material.dart';
import 'package:flutter_chat_2/home_chat.dart';

//TERCEROS
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamChatClient _client;

  @override
  void initState() {
    _client = StreamChatClient('5hryyjstspxg', logLevel: Level.INFO);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        builder: (context, child) {
          return StreamChat(
            client: _client, 
            child: child);
        },
        home: const HomeChat());
  }
}
