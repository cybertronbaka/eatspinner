import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';

class ContactsView extends StatelessWidget{
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            'A',
            style: TextStyle(
              color: Color(0xFF626262),
              fontSize: 18
            ),
          ),
        ),
        Divider(indent: 5, endIndent: 5),
        ContactCard(),
        ContactCard(),
        ContactCard()
      ],
    );
  }
}