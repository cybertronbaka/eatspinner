import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';

class ProfileMenuPage extends StatelessWidget{
  const ProfileMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: SpacedColumn(
            spaceHeight: 10,
            children: [
              const ProfileCard(),
              const SizedBox(height: 10),
              ProfileMenuItem(
                title: 'View Profile',
                icon: const Icon(Icons.visibility_outlined, color: Color(0xFF626262)),
                onTap: (){},
              ),
              ProfileMenuItem(
                title: 'Eat Spinner',
                icon: const Icon(Icons.gamepad_outlined, color: Color(0xFF626262)),
                onTap: (){},
              ),
              ProfileMenuItem(
                title: 'Share Profile Link',
                icon: const Icon(Icons.link_outlined, color: Color(0xFF626262)),
                onTap: (){},
              ),
              ProfileMenuItem(
                title: 'Logout',
                icon: const Icon(Icons.logout_outlined, color: Color(0xFF626262)),
                onTap: (){},
              )
            ],
          ),
        ),
      ),
    );
  }
}
