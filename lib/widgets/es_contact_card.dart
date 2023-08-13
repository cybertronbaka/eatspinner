import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget{
  const ContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Container(
          height: 80,
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          'assets/images/icon.png',
                        )
                    ),
                  )
              ),
              const Expanded(
                flex: 5,
                child: Text(
                    'Arjun Rampal',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.more_horiz_outlined)
                  )
                ],
              )
            ],
          )
      ),
    );
  }
}