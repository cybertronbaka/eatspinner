import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget{
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Row(
          children: [
            ProfilePhoto(
              url: 'https://images6.alphacoders.com/126/1261894.jpg',
              diameter: 30,
            ),
            SizedBox(width: 8),
            Text('Sonam Dorji')
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.more_horiz_outlined)
          )
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: SingleChildScrollView(
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ChatTextBubble(isSender: false, text: 'Hi. I need you help. Can you please share me your contact number?'),
                ChatTextBubble(isSender: false, text: 'Okay?'),
                ChatTextBubble(isSender: true, text: 'Okay bro'),
                ChatTextBubble(isSender: true, text: '.')
              ],
            ),
          ))),
          MessageBar(
            onSend: (_) => print(_),
            actions: [
              EsCircularIconButton(
                  onTap: (){},
                  icon: const Icon(Icons.image_outlined)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: EsCircularIconButton(
                    onTap: (){},
                    icon: const Icon(Icons.mic_none_outlined)
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}