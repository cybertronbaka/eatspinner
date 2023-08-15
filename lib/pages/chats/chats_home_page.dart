import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/pages/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatsHomePage extends StatefulWidget{
  const ChatsHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _ChatsHomePageState();
}

class _ChatsHomePageState extends State<ChatsHomePage>{
  @override
  void initState() {
    dLink.handleOnRunning(context, 'authenticatedApp');
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eat Spinner'), // TODO: Add name by keeping profile info in localStorage
        actions: [
          IconButton(
            onPressed: (){
              context.push(Routes.notifications);
            },
            icon: const Stack(
              children: [
                Icon(Icons.notifications_outlined),
                // TODO: show only when there is notifications
                Positioned(  // draw a red marble
                  top: 0.0,
                  right: 0.0,
                  child: Icon(Icons.brightness_1, size: 12.0, color: Colors.redAccent),
                )
              ],
            )
          ),
          IconButton(
            onPressed: (){
              context.push(Routes.profileMenu);
            },
            icon: const Icon(Icons.menu_outlined)
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: EsStringTabBarView(
          tabs: [
            'All Chats',
            'Contacts'
          ],
          views: [
            AllChatsView(),
            ContactsView()
          ],
        )
      )
    );
  }
}