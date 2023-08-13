import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            context.pop();
          },
        ),
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: (){
                // context.push(Routes.addPlace);
              },
              icon: const Icon(Icons.edit_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() => SpacedColumn(
              spaceHeight: 20,
              children: [
                const SizedBox(height: 30),
                const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/login_image.jpg')
                  ),
                ),
                Text(
                  controller.profile.value!.name ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
                Text(
                  controller.profile.value!.email ?? '-',
                )
              ],
            )),
          )
      ),
    );
  }
}