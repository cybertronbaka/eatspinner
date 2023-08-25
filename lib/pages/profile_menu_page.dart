import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class ProfileMenuPage extends StatelessWidget{
  const ProfileMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<MyProfileController>();
    profileController.fetchProfile();

    return Scaffold(
      appBar: AppBar(
        leading: Obx((){
          return BackButton(
            onPressed: profileController.isLoggingOut.isTrue ? null : (){
              context.pop();
            },
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SpacedColumn(
          spaceHeight: 10,
          children: [
            Obx((){
              return ProfileCard(
                profile: profileController.profile.value
              );
            }),
            const SizedBox(height: 10),
            ProfileMenuItem(
              title: 'View Profile',
              icon: const Icon(Icons.visibility_outlined, color: Color(0xFF626262)),
              onTap: (){
                context.pushNamed(
                  Routes.profile,
                  pathParameters: { 'id': supabase.auth.currentUser!.id }
                );
              },
            ),
            ProfileMenuItem(
              title: 'Play Eat Spinner',
              icon: const Icon(Icons.gamepad_outlined, color: Color(0xFF626262)),
              onTap: (){
                context.push(Routes.spinner);
              },
            ),
            ProfileMenuItem(
              title: 'Share Profile Link',
              icon: const Icon(Icons.link_outlined, color: Color(0xFF626262)),
              onTap: (){
                Share.share('${dotenv.env['NEXT_URL']}/profile/${supabase.auth.currentUser!.id}');
              },
            ),
            ProfileMenuItem(
              title: 'Logout',
              icon: const Icon(Icons.logout_outlined, color: Color(0xFF626262)),
              onTap: (){
                profileController.logout().then((value){
                  if(value){
                    context.pop();
                    context.pushReplacement(Routes.root);
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

