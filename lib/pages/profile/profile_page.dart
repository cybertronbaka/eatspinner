import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/pages/profile/_all.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const coverPhotoHeight = 150.0;
    final controller = Get.find<ProfileController>();
    controller.fetchProfile();

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        leading: BackButton(
          onPressed: (){
            try{
              context.pop();
            } catch(e){
              context.pushReplacement(Routes.root);
            }
          },
        ),
        title: Obx((){
          if(controller.isFetching.value){
            return const Text('');
          } else {
            return Text(controller.profile.value?.name ?? '-');
          }
        }),
      ),
      body: Obx((){
        return controller.isFetching.isFalse
            ? ListView(
            children: [
              SizedBox(
                height: coverPhotoHeight * 1.3,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CoverPhoto(
                      url: StorageUtils.getPublicUrl(controller.profile.value?.coverUrl),
                      height: coverPhotoHeight,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: ProfilePhoto(
                        url: StorageUtils.getPublicUrl(controller.profile.value?.avatarUrl),
                        hasBorder: true,
                        diameter: coverPhotoHeight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (controller.profile.value?.name != null && controller.profile.value!.name != ''
                        ? Text(
                            controller.profile.value!.name!,
                            style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600
                            )
                          )
                        : Container()
                    ),
                    ...(controller.profile.value?.bio != null && controller.profile.value!.bio != ''
                      ? [
                        const SizedBox(height: 8),
                          Text(
                            controller.profile.value!.bio!.trim(),
                            style: const TextStyle(
                              fontSize: 14, color: Color(0xFF626262)
                            ),
                          )
                        ]
                        : [Container()]
                    ),
                    const SizedBox(height: 20),
                    if(supabase.auth.currentUser?.id != controller.uid) Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 50,
                            child: EsFilledButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: controller.actionMode.value.callback(context, controller),
                              labelText: controller.actionMode.value.labelText()
                              ),
                            ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 50,
                          width: 60,
                          child:  EsFilledIconButton(
                              onPressed: controller.actionMode.value.canSendMessage() ? (){

                              } : null,
                              icon: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 0),
                                child: Icon(Icons.message_outlined),
                              )
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 50,
                          width: 60,
                          child: EsFilledIconButton(
                              onPressed: controller.actionMode.value.moreActions(context, controller).isEmpty ? null : (){
                                _showMoreBottomSheet(context, controller);
                              },
                              icon: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 0),
                                child: Icon(Icons.more_horiz_outlined),
                              )
                          ),
                        )
                      ],
                    ),
                    if(supabase.auth.currentUser?.id != controller.uid) const SizedBox(height: 30),
                    buildDetail(controller.profile.value)
                  ],
                ),
              )
            ]
        )
            : ProfilePageShimmer(isMine: supabase.auth.currentUser?.id == controller.uid);
      }),
    );
  }

  void _showMoreBottomSheet(BuildContext context, ProfileController controller){
    showModalBottomSheet(
        context: context,
        builder: (ctx){
          return BottomSheet(
            onClosing: (){},
            builder: (ctx){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: controller.actionMode.value.moreActions(context, controller).map((e){
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: e.widget,
                        title: Text(e.title),
                        onTap: e.callback,
                      ),
                      const Divider(),
                      const SizedBox(height: 5),
                    ],
                  );
                }).toList(),
              );
            },
          );
        }
    );
  }

  Widget buildDetail(Profile? profile){
    final List<(IconData, String, String?)> values = [
      (Icons.flag_outlined, 'Gender', profile?.gender),
      (Icons.email_outlined, 'Email', profile?.email),
      (Icons.check_outlined, 'Age', '${profile?.age ?? '-'}'),
      (Icons.calendar_month_outlined, 'Join Date', profile?.createdAt)
    ];

    return SpacedColumn(
      spaceHeight: 15,
      children: values.map((val) {
        final (icon, name, value) = val;
        return Row(
          children: [
            Icon(icon, color: const Color(0xFF3D3D3C)),
            const SizedBox(width: 10),
            Expanded(child: Text(
              name, style: const TextStyle(color: Color(0xFF626262), fontWeight: FontWeight.w400),
            )),
            Text(
              value ?? '-', textAlign: TextAlign.right,
              style: const TextStyle(color: Color(0xFF3D3D3C),  fontWeight: FontWeight.w400),
            )
          ],
        );
      }).toList(),
    );
  }
}
