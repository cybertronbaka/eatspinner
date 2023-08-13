import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget{
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: CircleAvatar(
              radius: 70,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/icon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 5,
            child: SpacedColumn(
              spaceHeight: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sonam Dorji Tashi',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
                Text(
                  '${'Life is a mess. This is my bio of 100 characters.'.substring(0, 30)}...',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF626262)
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.edit_outlined)
          )
        ],
      ),
    );
  }
}