import 'package:flutter/material.dart';
import 'package:flutter_chat_2/data_utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendsChat extends StatefulWidget {
  const FriendsChat({Key? key}) : super(key: key);

  @override
  _FriendsChatState createState() => _FriendsChatState();
}

class _FriendsChatState extends State<FriendsChat> {
  final _keyChannels = GlobalKey<ChannelsBlocState>();

  Future<void> _onCreateChannel() async {
    final result = await showDialog(
        context: context,
        builder: (context) {
          final channelController = TextEditingController();
          return AlertDialog(
            title: const Text('Crear canal'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Bienvenido al chat publico'),
                TextField(
                  controller: channelController,
                  decoration: const InputDecoration(
                    hintText: 'Nombre del canal',
                  ),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pop(channelController.text),
                  child: const Text('Guardar'),
                ),
              ],
            ),
          );
        });

    //Si presiona fuera del Alertdialog se creara un canal
    if (result != null) {
      final client = StreamChat.of(context).client;
      final channel = client.channel('messaging', id: result, extraData: {
        'image': DataUtils.getChannelImage(),
      });
      await channel.create();
      _keyChannels.currentState?.queryChannels(); //PUEDE SER NULO
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _onCreateChannel, label: const Text('Crear canal')),
      appBar: AppBar(
        title: const Text('Chat publico'),
      ),
      body: ChannelsBloc(
        //los canales

        key: _keyChannels,
        child: ChannelListView(
          channelWidget: const ChannelPage(),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChannelHeader(),
      body: Column(
        children: const [
          Expanded(
            child: MessageListView(),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
