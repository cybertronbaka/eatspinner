import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget{
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text('Notifications'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: const [
          Text(
            'Today',
            style: TextStyle(
              color: Color(0xFF626262)
            ),
          ),
          Divider(),
          NotificationCard(),
          NotificationCard()
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const ProfilePhoto(
            url: 'https://images6.alphacoders.com/126/1261894.jpg',
            diameter: 60,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      'Sangay Wangchen ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text('wants to add you.')
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Ink(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.redAccent
                            ),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: InkWell(
                          onTap: (){},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                            child: Text(
                              'Reject',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Material(
                      color: Colors.transparent,
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: InkWell(
                          onTap: (){},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}