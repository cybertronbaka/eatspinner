import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';

class EsChatCard extends StatelessWidget{
  const EsChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      onLongPress: (){

      },
      child: Container(
        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10, left: 5),
        height: 80,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    radius: 60,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: SpacedColumn(
                spaceHeight: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sonam Dorji',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  Text(
                    '${'Hello there! How are you doing? Hope you are doing well. I wish I could chat with you.'.substring(0, 30)}...',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF626262)
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Text(
              '9:45 AM',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF626262)
              ),
            )
          ],
        ),
      ),
    );
  }
}