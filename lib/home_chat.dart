import 'package:flutter/material.dart';
import 'package:flutter_chat_2/data_utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'friends_chat.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({Key? key}) : super(key: key);

  @override
  _HomeChatState createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  final _usernameController = TextEditingController();
  //late String _usernameError;       //Si tomo el error no me toma el usuario
  bool _loading = false;

  //Capturamos el nombre de usuario
  Future<void> _onGoPressed() async {
    final username = _usernameController.text;

    if (username.isNotEmpty) {
      final client = StreamChat.of(context).client;
      //final client = StreamChatClient('b67pax5b2wdq',logLevel: Level.INFO);
      //final user = client.state.users;

      setState(() {
        _loading = true;
      });

      await client.connectUser(
          User(id: username, extraData: {
            'image': DataUtils.getUserImage(username),
          }),
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c'); //EL TOKEN
      //client.devToken(username));

      setState(() {
        _loading = false;
      });

      //************* NAVIGATOR **************   */
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const FriendsChat(), //Para listar y crear los canales
        ),
      );
    } else {
      setState(() {
        //_usernameError = 'El usuario no es valido';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Mostraremos un formulario donde el usuario ingresara los datos
      appBar: AppBar(
        title: const Text('Stream chat'),
      ),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : Card(
                elevation: 11,
                margin: const EdgeInsets.all(15.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Bienvenido al chat publico'),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          //errorText: _usernameError,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: _onGoPressed, child: const Text('GO')),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
